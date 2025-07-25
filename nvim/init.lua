-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

if vim.g.vscode then

else
    -- Setup lazy.nvim
    require("lazy").setup({
        spec = {
            -- import your plugins
            { import = "plugins" },
        },
        -- automatically check for plugin updates
        checker = { enabled = true },
    })

    vim.opt.clipboard = "unnamedplus"

    vim.diagnostic.config({
        virtual_text = {
            prefix = "●",
            format = function(diagnostic)
                return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
            end,
        },
        signs = false,
        underline = {
            severity = {
                min = vim.diagnostic.severity.HINT,
                max = vim.diagnostic.severity.ERROR,
            },
        },
        update_in_insert = false,
        severity_sort = true,
    })
    vim.opt.signcolumn = "yes"
    vim.opt.termguicolors = true
    vim.opt.winblend = 0
    vim.opt.pumblend = 0

    vim.o.number = true
    vim.o.cursorline = true

    vim.o.updatetime = 100
    vim.o.expandtab = true
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.opt.completeopt = { "menuone", "noselect", "popup" }

    -- Telescope setting
    local telescope = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", telescope.find_files, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fg", telescope.live_grep, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fb", telescope.buffers, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fh", telescope.help_tags, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>b", telescope.buffers, { noremap = true, silent = true })

    local colors = require("catppuccin.palettes").get_palette("mocha")
    vim.api.nvim_set_hl(0, "WinSeparator", {
        fg = colors.lavender,
        bg = "NONE",
    })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", {
        fg = colors.lavender,
        bg = "NONE",
    })
end
-- vim.o.winbar = require("rc.ui.statusline").statusline()
-- vim.cmd.colorscheme("catppuccin-mocha")
-- local devicons = require("nvim-web-devicons")

-- vim.api.nvim_create_autocmd({ "BufWinEnter", "BufFilePost", "BufWritePost", "TextChanged" }, {
-- 	callback = function()
-- 		local file = vim.fn.expand("%:t")
-- 		if file == "" then
-- 			vim.wo.winbar = ""
-- 			return
-- 		end
--
-- 		-- local icon, icon_hl = devicons.get_icon(file, vim.fn.expand("%:e"), { default = true })
-- 		local modified = vim.bo.modified and " ●" or ""
--
-- 		vim.wo.winbar = string.format("%%#%s#%s %%#Normal# %s%s", file, modified)
-- 		-- vim.wo.winbar = string.format("%%#%s#%s %%#Normal# %s%s", icon_hl, icon, file, modified)
-- 	end,
-- })

-- Clipboard keybindings
-- Normal mode and Visual mode
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<leader>p", '"+p', { noremap = true, silent = true })
