return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruvbox")
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("lualine").setup({
        icons_enabled = true,
        theme = "gruvbox",
      })
    end
  },
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "super-tab" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    build = function() require('blink.cmp').build():pwait() end
  },


  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end
      },
    },
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "LspAttach",
    opts = {
      picker = {
        "telescope",
        opts = {
          initial_mode = "normal",
          layout_strategy = "vertical",
        }
      }
    },
    keys = {
      {
        "<leader>ca",
        function() require("tiny-code-action").code_action() end,
        mode = { "n", "x" },
        desc = "Code action",
      },
    },
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      -- suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },

  -- Basic ============================
  "folke/which-key.nvim",
  "lewis6991/gitsigns.nvim",
  {
    "cappyzawa/trim.nvim",
    opts = {},
  },
  "mateuszwieloch/automkdir.nvim",
  "romainl/vim-cool",     -- Clears search highlight when not in search
  "lambdalisue/vim-suda", -- Write root files
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  -- Syntax ===========================
  "lark-parser/vim-lark-syntax",
  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {},
    config = function()
      vim.api.nvim_set_hl(0, "RenderMarkdownInlineHighlight", { bg = "#FABD2F", fg = "#282828" })
    end
  },

  -- Other ============================
  "ThePrimeagen/vim-be-good",

}
