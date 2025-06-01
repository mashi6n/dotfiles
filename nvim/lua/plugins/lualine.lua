return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local active_winbar = require("rc.ui.statusline").active_winbar
        local inactive_winbar = require("rc.ui.statusline").inactive_winbar
        local active_status = require("rc.ui.statusline").active_status
        require("lualine").setup({
            theme = "catppuccin",
            sections = {
                lualine_x = { "encoding", { "fileformat", symbols = { unix = "" } }, "filetype" },
                -- lualine_a = {},
                -- lualine_b = {},
                -- lualine_c = { active_status },
                -- lualine_x = {},
                -- lualine_y = {},
                -- lualine_z = {},
            },
            winbar = {
                lualine_c = {
                    active_winbar,
                    -- 		{
                    -- 			"filename",
                    -- 			path = 1,
                    -- 			separator = { right = "|" },
                    -- 			color = { gui = "bold" },
                    -- 		},
                    -- 		{
                    -- 			"navic",
                    -- 			color_correction = "static",
                    -- 			navic_opts = nil,
                    -- 		},
                },
            },
            inactive_winbar = {
                lualine_c = {
                    inactive_winbar,
                },
            },
        })
    end,
}
