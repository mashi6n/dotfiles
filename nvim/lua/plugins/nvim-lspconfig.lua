return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", config = true },
		{ "mason-org/mason-lspconfig.nvim" },
	},
	config = function()
		local servers = {
			"lua_ls",
			"bashls",
			"clangd",
			"cssls",
			"dockerls",
			"docker_compose_language_service",
			"gopls",
			"html",
			"jsonls",
			-- "pylsp",
			"pyright",
			-- "ty",
			"ruff",
			"ts_ls",
			"rust_analyzer",
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})
		vim.lsp.enable(servers)

		local aug = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = aug,
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local opts = { buffer = bufnr, silent = true, noremap = true }

				-- keymaps
				-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				-- enable completion
				-- vim.lsp.completion.enable(true, client.id, bufnr, {
				--     autotrigger = true,
				--     convert = function(item)
				--         return { addr = item.label:gsub("%b()", "") }
				--     end,
				-- })
			end,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
			callback = function(args)
				-- async=false で同期実行。大ファイルが気になるなら true に
				vim.lsp.buf.format({ bufnr = args.buf, async = false, timeout = 3000 })
				vim.cmd("write")
			end,
		})
		-- vim.api.nvim_create_autocmd("CursorHold", {
		-- 	callback = function()
		-- 		vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
		-- 	end,
		-- })
	end,
}
