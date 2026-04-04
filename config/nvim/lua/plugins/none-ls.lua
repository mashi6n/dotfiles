return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    opts = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
            },
        })

        require("mason-null-ls").setup({
            ensure_installed = { "stylua" },
            automatic_installation = true,
        })
    end,
}
