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
    "folke/lazydev.nvim", -- for vim-specific lua
    ft = "lua", -- only load on lua
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
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
}
