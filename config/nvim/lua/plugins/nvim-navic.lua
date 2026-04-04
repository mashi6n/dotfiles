return {
	"SmiteshP/nvim-navic",
	dependencies = { "neovim/nvim-lspconfig" },
	enabled = false,
	opts = {
		lsp = {
			auto_attach = true,
		},
		highlight = true,
		icons = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = " ",
			Interface = " ",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = " ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = " ",
			EnumMember = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},
	},
	config = function(_, opts)
		require("nvim-navic").setup(opts)
		vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
			callback = function()
				vim.schedule(function()
					local navic = require("nvim-navic")
					-- local excluded = { "NvimTree", "neo-tree", "toggleterm", "Outline", "help", "" }
					-- local ft = vim.bo.filetype
					--
					-- if vim.tbl_contains(excluded, ft) or not navic.is_available() then
					-- 	vim.wo.winbar = "hoge"
					-- 	return
					-- end

					vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
				end)
			end,
		})
	end,
}
