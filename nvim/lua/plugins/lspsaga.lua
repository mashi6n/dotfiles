return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	opts = {
		border_style = "single",
		symbol_in_winbar = {
			enable = true,
		},
		code_action_lightbulb = {
			enable = true,
		},
		show_outline = {
			win_width = 50,
			auto_preview = false,
		},
	},
	config = function(_, opts)
		require("lspsaga").setup(opts)
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
		vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>")
		vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
		vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>")
		vim.keymap.set("n", "gn", "<cmd>Lspsaga rename<CR>")
		vim.keymap.set("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>")
		vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

		vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>")
		-- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>")
		vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
	end,
}
