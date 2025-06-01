return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "c",
                "cpp",
                "rust",
                "go",
                "terraform",
                "html",
                "xml",
                "javascript",
                "typescript",
                "tsx",
                "python",
                "make",
                "css",
                "csv",
                "json",
                "yaml",
                "toml",
            },
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            autotag = { enable = true },
        })
    end,
}
