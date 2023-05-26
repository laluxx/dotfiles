return {
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>n",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      icons = {
        ERROR = " ",
        INFO = " ",
        WARN = " ",
      },
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      local util = require("tvl.util")
      if not util.has("noice.nvim") then
        util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPost" },
    opts = {
      options = {
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        -- separator_style = "", -- | "thick" | "thin" | "slope" | { 'any', 'any' },
        -- separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
        separator_style = "slant", -- | "thick" | "thin" | { 'any', 'any' },
        indicator = {
          -- icon = " ",
          -- style = 'icon',
          style = "underline",
        },
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        diagnostics_indicator = function(count, _, _, _)
          if count > 9 then
            return "9+"
          end
          return tostring(count)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "EXPLORER",
            text_align = "center",
            -- separator = true,
          },
        },
        hover = {
          enabled = true,
          delay = 0,
          reveal = { "close" },
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      local lualine_config = require("tvl.config.lualine")
      lualine_config.setup({
        float = false,
        separator = "bubble", -- bubble | triangle
        ---@type any
        colorful = true,
      })
      lualine_config.load()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "▏",
      context_char = "▏",
      show_end_of_line = false,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "neo-tree",
      },
      buftype_exclude = {
        "terminal",
        "nofile",
      },
      -- char_highlight_list = {
      --   "IndentBlanklineIndent1",
      --   "IndentBlanklineIndent2",
      --   "IndentBlanklineIndent3",
      --   "IndentBlanklineIndent4",
      --   "IndentBlanklineIndent5",
      --   "IndentBlanklineIndent6",
      -- },
    },
  },

  {
    "echasnovski/mini.indentscope",
    lazy = true,
    enabled = true,
    -- lazy = true,
    version = false, -- wait till new 0.7.0 release to put it back on semver
    -- event = "BufReadPre",
    opts = {
      symbol = "▏",
      -- symbol = "│",
      options = { try_as_border = false },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },

  {
    "utilyre/barbecue.nvim",
    event = { "BufReadPost" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "auto",
      include_buftypes = { "" },
      exclude_filetypes = { "gitcommit", "Trouble", "toggleterm" },
      show_modified = false,
      kinds = {
        File = "", -- File
        Module = "", -- Module
        Namespace = "", -- Namespace
        Package = "", -- Package
        Class = "", -- Class
        Method = "", -- Method
        Property = "", -- Property
        Field = "", -- Field
        Constructor = "", -- Constructor
        Enum = "", -- Enum
        Interface = "", -- Interface
        Function = "", -- Function
        Variable = "", -- Variable
        Constant = "", -- Constant
        String = "", -- String
        Number = "", -- Number
        Boolean = "◩", -- Boolean
        Array = "", -- Array
        Object = "", -- Object
        Key = "", -- Key
        Null = "ﳠ", -- Null
        EnumMember = "", -- EnumMember
        Struct = "", -- Struct
        Event = "", -- Event
        Operator = "", -- Operator
        TypeParameter = "", -- TypeParameter
        Macro = "", -- Macro
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    event = { "BufReadPost" },
    opts = {
      open_mapping = [[<C-\>]],
      start_in_insert = true,
      direction = "float",
      autochdir = false,
      float_opts = {
        border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" }, -- [ top top top - right - bottom bottom bottom - left ]
        -- border = { " ", "▁", " ", "▎", " ", "▔", " ", "▕" }, -- [ top top top - right - bottom bottom bottom - left ]
        -- border = "single",
        winblend = 0,
      },
      highlights = {
        FloatBorder = { link = "ToggleTermBorder" },
        Normal = { link = "ToggleTerm" },
        NormalFloat = { link = "ToggleTerm" },
      },
      winbar = {
        enabled = true,
        name_formatter = function(term)
          return string.format("%d:%s", term.id, term:_display_name())
        end,
      },
    },
  },

  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    keys = { { "<leader>0", "<cmd>Dashboard<CR>", desc = "Dashboard" } },
    config = function()
      require("tvl.config.dashboard")
    end,
  },

  -- {
  --   "goolord/alpha-nvim",
  --   event = "VimEnter",
  --   keys = { { "<leader>a", "<cmd>Alpha<cr>", "Alpha" } },
  --   config = function()
  --     require("tvl.config.alpha")
  --   end,
  -- },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      set_highlights = false,
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "neo-tree",
        "dashboard",
        "alpha",
        "lazy",
        "mason",
        "DressingInput",
        "",
      },
      handlers = {
        gitsigns = true,
      },
    },
  },

  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = true },
    },
    opts = {
      animation = { enable = true, duration = 150, fps = 60 },
      autowidth = { enable = true },
    },
    keys = { { "<leader>m", "<cmd>WindowsMaximize<CR>", desc = "Zoom window" } },
    init = function()
      vim.o.winwidth = 30
      vim.o.winminwidth = 30
      vim.o.equalalways = true
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*", "!lazy", "!neo-tree" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {
      input = {
        border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" }, -- [ top top top - right - bottom bottom bottom - left ]
        win_options = { winblend = 0 },
      },
      select = { telescope = require("tvl.util").telescope_theme() },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    "kosayoda/nvim-lightbulb",
    opts = {
      sign = {
        enabled = true,
        -- Priority of the gutter sign
        priority = 20,
      },
      status_text = {
        enabled = true,
        -- Text to provide when code actions are available
        text = "status_text",
        -- Text to provide when no actions are available
        text_unavailable = "",
      },
      autocmd = {
        enabled = true,
        -- see :help autocmd-pattern
        pattern = { "*" },
        -- see :help autocmd-events
        events = { "CursorHold", "CursorHoldI", "LspAttach" },
      },
    },
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = "cmdline",
        format = {
          cmdline = { icon = "  " },
          search_down = { icon = "  󰄼" },
          search_up = { icon = "  " },
          lua = { icon = " " },
        },
      },
      lsp = {
        progress = { enabled = true },
        hover = { enabled = false },
        signature = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "%d+L, %d+B",
          },
        },
      },
    },
  },
}
