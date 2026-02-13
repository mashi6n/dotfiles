return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		-- nvim . で最初に netrw が開かないように先に無効化
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	opts = {
		disable_netrw = true,
		hijack_netrw = true,
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		renderer = {
			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
			},
		},
	},
	keys = {
		{ mode = "n", "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		{ mode = "n", "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus NvimTree" },
	},
}
