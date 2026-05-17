vim.keymap.set("n","<leader>ft",vim.lsp.buf.format)
vim.keymap.set("n","K", vim.lsp.buf.hover)
vim.keymap.set("n","gd", vim.lsp.buf.definition)
vim.keymap.set("n","gr", vim.lsp.buf.references)
vim.keymap.set("n","<leader>rn", vim.lsp.buf.rename)

