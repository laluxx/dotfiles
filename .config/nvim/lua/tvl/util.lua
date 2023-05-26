local M = {}

M.root_patterns = { ".git", "lua", "package.json", "mvnw", "gradlew", "pom.xml", "build.gradle", "release", ".project" }

M.has = function(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

--- @param on_attach fun(client, buffer)
M.on_attach = function(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

M.get_highlight_value = function(group)
  local found, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
  if not found then
    return {}
  end
  local hl_config = {}
  for key, value in pairs(hl) do
    _, hl_config[key] = pcall(string.format, "#%02x", value)
  end
  return hl_config
end

M.get_root = function()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace
          and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

M.set_root = function(dir)
  vim.api.nvim_set_current_dir(dir)
end

---@param type "ivy" | "dropdown" | "cursor" | nil
M.telescope_theme = function(type)
  if type == nil then
    return {
      borderchars = { "█", "█", "▀", "█", "█", "█", "▀", "▀" },
      layout_config = {
        width = 80,
        height = 0.5,
      },
    }
  end
  return require("telescope.themes")["get_" .. type]({
    cwd = M.get_root(),
    borderchars = { "█", "█", "▔", "█", "█", "█", "▔", "▔" },
  })
end

---@param type "ivy" | "dropdown" | "cursor" | nil
M.telescope = function(builtin, type, opts)
  local params = { builtin = builtin, type = type, opts = opts }
  return function()
    builtin = params.builtin
    type = params.type
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
    local theme
    if vim.tbl_contains({ "ivy", "dropdown", "cursor" }, type) then
      theme = M.telescope_theme(type)
    else
      theme = opts
    end
    require("telescope.builtin")[builtin](theme)
  end
end

---@param name "autocmds" | "options" | "keymaps"
M.load = function(name)
  local Util = require("lazy.core.util")
  -- always load lazyvim, then user file
  local mod = "tvl.core." .. name
  Util.try(function()
    require(mod)
  end, {
    msg = "Failed loading " .. mod,
    on_error = function(msg)
      local modpath = require("lazy.core.cache").find(mod)
      if modpath then
        Util.error(msg)
      end
    end,
  })
end

M.on_very_lazy = function(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

M.capabilities = function(ext)
  return vim.tbl_deep_extend(
    "force",
    {},
    ext or {},
    require("cmp_nvim_lsp").default_capabilities(),
    { textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } } }
  )
end

return M
