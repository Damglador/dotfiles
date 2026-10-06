require('telescope').setup({
  defaults = {
    layout_config = {
      width = 0.95,
      preview_width = 0.50,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    frecency = {
      default_workspace = 'CWD',
    },
  }
})

local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions

vim.keymap.set('n', '<leader>ff', function()
  extensions.smart_open.smart_open({ cwd_only = true })
end, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>r', function()
  extensions.smart_open.smart_open()
end, { desc = 'Recent files' })
