vim.lsp.config("pylsp", {
    plugins = {
        mccabe = {
            enabled = false
        },
        jedi = {
            fuzzy = false
        }
    }
})
