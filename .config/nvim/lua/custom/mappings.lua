---@type MappingsTable
local M = {}

M.general = {
  n = { -- Normal mode mappings
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  i = { -- Insert mode mappings
    -- add here
  },
  v = {  -- Visual mode mappings
    -- add here
  },

  c = {  -- Command-Line mode mappings
    -- add here
  },
}

-- Leader key mappings for window splitting
M.leaderMappings = {
    n = {
        -- EVIL WINDOW MANAGMENT
        ["<leader>ww"] = { "<C-w>w", "switch windows" },
        ["<leader>wc"] = { "<C-w>c", "close window" },
        ["<leader>wx"] = { "<C-w>x", "exchange window" },
        ["<leader>wv"] = { "<C-w>v", "split window vertically" },
        ["<leader>ws"] = { "<C-w>s", "split window horizontally" },
    },
}


M.telescopeMappings = {
    n = {
        -- FILE
        -- ["<leader>ff"] = { "<cmd>Telescope find_files<CR>", "find files" },
        ["<leader>fg"] = { "<cmd>Telescope live_grep<CR>", "live grep" },
        ["<leader>fr"] = { "<cmd>Telescope oldfiles<CR>", "recent files" },--
        ["<leader>fb"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "fuzzy find in current buffer" },
        ["<leader>fs"] = { "<cmd>w<CR>", "save file" },

        -- FIND
        ["<leader>fm"] = { "<cmd>Telescope man_pages<CR>", "man pages" },
        ["<leader>fo"] = { "<cmd>Telescope vim_options<CR>", "vim options" },
        ["<leader>ft"] = { "<cmd>Telescope filetypes<CR>", "file types" },

        -- HELP
        ["<leader>hh"] = { "<cmd>Telescope help_tags<CR>", "help tags" },
        ["<leader>hk"] = { "<cmd>Telescope keymaps<CR>", "view keymaps" },


        -- BUFFERS
        ["<leader>bi"] = { "<cmd>Telescope buffers<CR>", "switch buffers" },
        ["<leader>bb"] = { "<cmd>Telescope buffers<CR>", "switch buffer" },

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
        ["<leader>tl"] = { "<cmd>call ToggleLineNumbers()<CR>", "toggle line numbers" },

        -- EMACS-COUNCIL
        ["<M-x>"] = { "<cmd>lua BottomPaneTelescope(require('telescope.builtin').commands)<CR>", "execute command" },
        ["<leader>ff"] = { "<cmd>lua BottomPaneTelescope(require('telescope.builtin').find_files)<CR>", "find files" },
    },
}


-- TELESCOPE MODES

function BottomPaneTelescope(telescope_func, options)
    options = options or {}
    options.layout_strategy = "bottom_pane"
    options.layout_config = {
        height = 10, -- adjust this to set how many results you want to show at once
        prompt_position = "bottom",
        width = 1.0
    }
    telescope_func(options)
end




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
