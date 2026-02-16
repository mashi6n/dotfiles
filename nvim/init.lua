-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

if vim.g.vscode then
    local vscode = require("vscode")
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, nowait = true, desc = desc })
    end
    map("n", "gd", function()
        vscode.action("editor.action.revealDefinition")
    end, "Go to Definition")
    map("n", "gr", function()
        vscode.action("editor.action.referenceSearch.trigger")
    end, "Find References")
    map("n", "gh", function()
        vscode.action("editor.action.showHover")
    end, "Hover")
    map("n", "<leader>rn", function()
        vscode.action("editor.action.rename")
    end, "Rename")
    -- map({ 'n','v' }, '<leader>f',  function() vscode.action('editor.action.formatDocument') end, 'Format')
    -- map({ 'n','v' }, '<leader>ca', function() vscode.action('editor.action.quickFix') end, 'Code Action')
    map({ "n", "v" }, "<leader>cr", function()
        vscode.action("editor.action.refactor")
    end, "Refactor")
    map("n", "gI", function()
        vscode.action("editor.action.goToImplementation")
    end, "Go to Implementation")
    map("n", "gt", function()
        vscode.action("editor.action.goToTypeDefinition")
    end, "Go to Type Definition")
else
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
    -- Setup lazy.nvim
    require("lazy").setup({
        spec = {
            -- import your plugins
            { import = "plugins" },
        },
        -- automatically check for plugin updates
        checker = {
            enabled = true,
            frequency = 86400, -- check for updates once per day
        },
    })

    vim.opt.clipboard = "unnamedplus"

    vim.diagnostic.config({
        virtual_text = false,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "▎",
                [vim.diagnostic.severity.WARN] = "▎",
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            },
            severity = {
                min = vim.diagnostic.severity.WARN,
            },
        },
        underline = {
            severity = {
                min = vim.diagnostic.severity.WARN,
            },
        },
        update_in_insert = false,
        severity_sort = true,
    })
    vim.opt.signcolumn = "yes"
    vim.opt.termguicolors = true
    vim.opt.guicursor = "a:blinkon0"
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
    vim.api.nvim_set_hl(0, "Normal", {
        bg = "#1e1e2e",
    })
    vim.api.nvim_set_hl(0, "NormalNC", {
        bg = "#161621",
    })
    vim.api.nvim_set_hl(0, "SignColumn", {
        bg = "#1e1e2e",
    })
    vim.api.nvim_set_hl(0, "SignColumnNC", {
        bg = "#161621",
    })
    vim.api.nvim_set_hl(0, "WinSeparator", {
        fg = colors.lavender,
        bg = "NONE",
    })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", {
        fg = colors.lavender,
        bg = "NONE",
    })
    vim.api.nvim_set_hl(0, "NvimTreeNormal", {
        bg = "#1e1e2e",
    })
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", {
        bg = "#161621",
    })
    vim.api.nvim_set_hl(0, "NvimTreeSignColumn", {
        bg = "#1e1e2e",
    })
    vim.api.nvim_set_hl(0, "NvimTreeSignColumnNC", {
        bg = "#161621",
    })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = colors.red, fg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = colors.yellow, fg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = colors.sky, fg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = colors.teal, fg = "NONE" })
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
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.cmd("startinsert")
    end,
})

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    group = vim.api.nvim_create_augroup("autosave_on_focuslost_bufleave", { clear = true }),
    callback = function(ev)
        local buf = ev.buf
        if vim.bo[buf].buftype ~= "" then
            return
        end
        if vim.api.nvim_buf_get_name(buf) == "" then
            return
        end
        if not vim.bo[buf].modifiable or vim.bo[buf].readonly then
            return
        end
        if not vim.bo[buf].modified then
            return
        end

        vim.api.nvim_buf_call(buf, function()
            vim.cmd("silent! update")
        end)
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "BlinkCmpMenuOpen",
    callback = function()
        vim.b.copilot_suggestion_hidden = true
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "BlinkCmpMenuClose",
    callback = function()
        vim.b.copilot_suggestion_hidden = false
    end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("blink_show_on_insert_enter", { clear = true }),
    callback = function()
        if vim.bo.buftype ~= "" then
            return
        end

        local ok, cmp = pcall(require, "blink.cmp")
        if not ok then
            return
        end

        vim.defer_fn(function()
            cmp.show()
        end, 80)
    end,
})

vim.keymap.set("t", "<C-w>h", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-w>j", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-w>k", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-w>l", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
