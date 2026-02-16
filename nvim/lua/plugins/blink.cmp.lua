return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		"L3MON4D3/LuaSnip",
		"giuxtaposition/blink-cmp-copilot",
	},

	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "default",
			["<Tab>"] = { "accept", "fallback" },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			list = {
				selection = { auto_insert = false },
			},
			documentation = { auto_show = true, auto_show_delay_ms = 50 },
			menu = {
				draw = {
					columns = { { "kind_icon" }, { "label", "copilot_label", gap = 1 } },
					padding = { 0, 1 }, -- padding only on right side
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
						kind_icon = {
							ellipsis = false,
							-- text = function(ctx)
							-- 	return require("lspkind").symbolic(ctx.kind, {
							-- 		mode = "symbol",
							-- 	})
							-- end,
							text = function(ctx)
								if ctx.source_name == "copilot" then
									return "  "
								end

								local lspkind = require("lspkind")
								local kind = ctx.kind or "Text"
								local icon = lspkind.symbol_map[kind] or "?"
								return " " .. icon .. " "
							end,
							highlight = function(ctx)
								return { { group = ctx.kind_hl, priority = 20000 } }
							end,
						},
						copilot_label = {
							width = { max = 10 },
							text = function(ctx)
								if ctx.source_name == "copilot" then
									return "Copilot"
								end
								return ""
							end,
							highlight = "BlinkCmpSource",
						},
					},
				},
				-- border = "rounded",
			},
		},

		signature = { enabled = true },

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "copilot" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
				},
			},
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },

		snippets = { preset = "luasnip" },
	},
	opts_extend = { "sources.default" },
}
