---@type MappingsTable
local M = {}

M.general = {
  n = { -- Normal mode mappings
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  i = { -- Insert mode mappings
    -- add here
  },

  c = {  -- Command-Line mode mappings
    -- add here
  },

  v = {  -- Visual mode mappings
    ["<Tab>"] = { ">gv", "indent selected lines and reselect them" }, -- evil tab
  },
}

-- Leader key mappings for window splitting
M.leaderMappings = {
    n = {
        -- EVIL WINDOW MANAGMENT
        ["<leader>ww"] = { "<C-w>w", "switch windows" }, ["<leader>wc"] = { "<C-w>c", "close window" }, ["<leader>wx"] = { "<C-w>x", "exchange window" },
        ["<leader>wv"] = { "<C-w>v", "split window vertically" },
        ["<leader>ws"] = { "<C-w>s", "split window horizontally" },
    },
}


M.telescopeMappings = {
    n = {
        -- FILE
        ["<leader>fg"] = { "<cmd>Telescope live_grep<CR>", "live grep" },
        ["<leader>fr"] = { "<cmd>Telescope oldfiles<CR>", "recent files" },--
        ["<leader>fb"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "fuzzy find in current buffer" },
        ["<leader>fs"] = { "<cmd>w<CR>", "save file" },
        ["<leader>fp"] = { "<cmd>execute 'cd' expand('~/.config/nvim/lua/custom') | lua FindFiles()<CR>", "find files in custom config directory" },
        ["<leader>ff"] = { "<cmd>lua FindFiles()<CR>", "browse files" },
        -- ["<leader>ft"] = { "<cmd>Telescope filetypes<CR>", "file types" },
        ["<leader>ft"] = { "<cmd>TodoTelescope<CR>", "TODO ENTRY" },

        -- DIRECTORY
        ["<leader>."] = { "<cmd>Telescope find_files<CR>", "Use Telescope as file manager" },

        -- HELP
        ["<leader>hh"] = { "<cmd>Telescope help_tags<CR>", "help tags" },
        ["<leader>hk"] = { "<cmd>Telescope keymaps<CR>", "view keymaps" },
        ["<leader>hm"] = { "<cmd>Telescope man_pages<CR>", "man pages" },
        ["<leader>ho"] = { "<cmd>Telescope vim_options<CR>", "vim options" },


        -- BUFFERS
        ["<leader>bi"] = { "<cmd>Telescope buffers<CR>", "switch buffers" },
        ["<leader>bb"] = { "<cmd>lua Council(require('telescope.builtin').buffers)<CR>", "switch buffer" },
        ["<leader>bn"] = { ":bnext<CR>", "next buffer" },
        ["<leader>bp"] = { ":bprevious<CR>", "previous buffer" },
        ["<leader>bd"] = { ":bd<CR>", "delete buffer" },
        ["<leader>bk"] = { "<cmd>lua DoomBufferKill()<CR>", "emulate Doom Emacs buffer kill" },
        
        -- COUNCIL
        ["<leader>si"] = { "<cmd>TodoTrouble<CR>", "git status" },

        -- GIT
        ["<leader>gs"] = { "<cmd>Telescope git_status<CR>", "git status" },
        ["<leader>gc"] = { "<cmd>Telescope git_commits<CR>", "git commits" },
        ["<leader>gd"] = { "<cmd>Telescope git_diff<CR>", "git diff" },
        ["<leader>gb"] = { "<cmd>Telescope git_branches<CR>", "git branches" },
        ["<leader>gr"] = { "<cmd>Telescope lsp_references<CR>", "LSP references" },

        -- LSP DONEOCUMENT
        ["<leader>de"] = { "<cmd>Telescope lsp_document_symbols<CR>", "LSP document symbols" },
        ["<leader>ds"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "LSP dynamic workspace symbols" },

        -- EDITING
        ["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP rename symbol" },

        -- TOGGLE
        ["<leader>tb"] = { "<cmd>ZenMode<CR>", "toggle big font mode" },
        ["<leader>tl"] = { "<cmd>call ToggleLineNumbers()<CR>", "toggle line numbers" },
        ["<leader>tt"] = { "<cmd>call ToggleWrap()<CR>", "Toggle line wrap" },
        ["<leader>tn"] = { "<cmd>:NvimTreeToggle<CR>", "Toggle nvim-tree" },
        ["<leader>tw"] = { "<cmd>:TroubleToggle<CR>", "Toggle nvim-tree" },

        -- EMACS
        ["<M-x>"] = { "<cmd>lua Council(require('telescope.builtin').commands)<CR>", "execute command" },
    },
}


-- FUNCTIONS

-- Define the function to toggle line numbers DONE
vim.api.nvim_exec([[
let g:linenumber_state = 'number'

function! ToggleLineNumbers()
    if g:linenumber_state == 'number'
        set relativenumber
        let g:linenumber_state = 'relativenumber'
    elseif g:linenumber_state == 'relativenumber'
        set nonumber
        set norelativenumber
        let g:linenumber_state = 'none'
    else
        set number
        let g:linenumber_state = 'number'
    endif
endfunction
]], false)


-- --  function that emulates Doom Emacs' buffer kill behavior
-- function _G.DoomBufferKill()
--   -- store the current buffer number
--   local cur_buf = vim.api.nvim_get_current_buf()
--   
--   -- get the list of all available buffers
--   local bufs = vim.api.nvim_list_bufs()
--
--   -- iterate over the buffers
--   for _, buf in ipairs(bufs) do
--     -- check if the buffer is valid and loaded
--     if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) and buf ~= cur_buf then
--       -- switch to this buffer
--       vim.api.nvim_set_current_buf(buf)
--       break
--     end
--   end




function _G.DoomBufferKill()
  -- store the current buffer number
  local cur_buf = vim.api.nvim_get_current_buf()
  
  -- get the list of all available buffers
  local bufs = vim.api.nvim_list_bufs()

  -- check if there is only one buffer left
  if #bufs == 1 then
    -- quit nvim
    vim.api.nvim_command('quit')
    return
  end

  -- iterate over the buffers
  for _, buf in ipairs(bufs) do
    -- check if the buffer is valid and loaded
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) and buf ~= cur_buf then
      -- switch to this buffer
      vim.api.nvim_set_current_buf(buf)
      break
    end
  end
end








--  -- check if the buffer to delete is different from the current buffer and if it exists
--  if cur_buf ~= vim.api.nvim_get_current_buf() and vim.api.nvim_buf_is_valid(cur_buf) then
--    -- delete the previous buffer
--    vim.api.nvim_buf_delete(cur_buf, { force = true })
--  end
--end


-- TELESCOPE MODES

function Council(telescope_func, options)
    options = options or {}
    options.layout_strategy = "bottom_pane"
    options.layout_config = {
        height = 10, -- adjust this to set how many results you want to show at once
        prompt_position = "bottom",
        width = 1.0
    }
    options.previewer = false -- Disable the preview window
    telescope_func(options)
end

function CouncilPreview(telescope_func, options)
    options = options or {}
    options.layout_strategy = "bottom_pane"
    options.layout_config = {
        height = 10, -- adjust this to set how many results you want to show at once
        prompt_position = "bottom",
        width = 1.0
    }
    telescope_func(options)
end

function FindFiles()
    local options = {}
    options.layout_strategy = "vertical"
    options.layout_config = {
        width = 0.25, -- adjust this to control the width of the file listing pane
    }
    options.hidden = true -- show hidden files
    require('telescope.builtin').find_files(options)
end


-- toggle truncated lines
vim.api.nvim_exec([[
function! ToggleWrap()
    if &wrap
        setlocal nowrap
    else
        setlocal wrap
    endif
endfunction
]], false)





-- Loop through the leader mappings and set them
for mode, mappings in pairs(M.leaderMappings) do
    for keys, mapping in pairs(mappings) do
        local opts = mapping.opts or {noremap = true, silent = true}
        vim.api.nvim_set_keymap(mode, keys, mapping[1], opts)
    end
end

-- more keybinds!

return M



-- ---@type MappingsTable
-- local M = {}
--
-- M.general = {
--   n = {
--     [";"] = { ":", "enter command mode", opts = { nowait = true } },
--   },
-- }
--
-- -- more keybinds!
--
-- return M
