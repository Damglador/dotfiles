require("nvim-treesitter").setup {
  ensure_installed = { "vim", "vimdoc", "lua", "cpp" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}
