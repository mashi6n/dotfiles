return {
	"nvim-tree/nvim-tree.lua",
	config = true,
	keys = {
		{ mode = "n", "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		{ mode = "n", "<C-m>", "<cmd>NvimTreeFocus<CR>", desc = "Focus NvimTree" },
	},
}
