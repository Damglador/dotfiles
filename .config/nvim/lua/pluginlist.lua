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

  "mateuszwieloch/automkdir.nvim",

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- optional but recommended
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    lazy = false,
    build = ":TSUpdate",
  },
  "lewis6991/gitsigns.nvim",
  "cappyzawa/trim.nvim",
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
  "lambdalisue/vim-suda", -- Write root files
  "ThePrimeagen/vim-be-good",
  "folke/which-key.nvim",
  "romainl/vim-cool", -- Clears search highlight when not in search
  "lark-parser/vim-lark-syntax",
}
