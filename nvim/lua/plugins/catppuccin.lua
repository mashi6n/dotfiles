return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha",
		transparent_background = true,
		styles = {
			conditionals = {},
			miscs = {},
		},
		default_integrations = true,
		integrations = {
			nvimtree = true,
			treesitter = true,
			blink_cmp = true,
			fidget = true,
			gitsigns = true,
			telescope = {
				enabled = true,
			},
			navic = {
				enabled = true,
				custom_bg = "NONE", -- "lualine" will set background to mantle
			},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
