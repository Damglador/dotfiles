vim.treesitter.start()

vim.b.completion = false -- disable blink.cmp tab-completion

vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- don't wrap mid-word
vim.opt_local.spell = true

vim.opt_local.conceallevel = 2 -- something for renderers
