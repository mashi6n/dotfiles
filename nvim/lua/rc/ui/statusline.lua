local M = {}

local colors = require("catppuccin.palettes").get_palette("mocha")

local highlight = require("rc.util").highlight

highlight.link({ StatusLine = "Normal" })
highlight.set({
    StatusLineInactive = { fg = colors.overlay1, bg = "NONE" },
    StatusLineNormal = { fg = colors.mauve, bg = "NONE" },
    StatusLineInsert = { fg = colors.green, bg = "NONE" },
    StatusLineVisual = { fg = colors.sapphire, bg = "NONE" },
    StatusLineReplace = { fg = colors.red, bg = "NONE" },
    StatusLineCommand = { fg = colors.peach, bg = "NONE" },
    StatusLineFilename = { fg = colors.rosewater, bg = "NONE" },
})

---@return string
local function mode()
    local m = string.lower(vim.fn.mode())
    if m == "n" then
        return "normal"
    elseif m == "i" then
        return "insert"
    elseif m == "c" then
        return "command"
    elseif m == "v" or m == "^V" or m == "s" then
        return "visual"
    elseif m == "r" then
        return "replace"
    end
    return "other"
end

---@return number
local function modified_bg_bufs_count()
    local cnt = 0
    for i = 1, vim.fn.bufnr("$") do
        if
            vim.fn.bufexists(i) == 1
            and vim.fn.buflisted(i) == 1
            and vim.fn.getbufvar(i, "buftype") == ""
            and vim.fn.filereadable(vim.fn.expand("#" .. i .. ":p"))
            and i ~= vim.fn.bufnr("%")
            and vim.fn.getbufvar(i, "&modified") == 1
        then
            cnt = cnt + 1
        end
    end
    return cnt
end

---@return boolean
local function is_active_win()
    return vim.api.nvim_get_current_win() == vim.api.nvim_get_selected_win()
end

---@param is_active boolean
M.filename = function(is_active)
    local file = vim.fn.expand("%:~:.")
    file = string.format(" %s ", file)
    -- local hl = is_active_win() and "%#StatusLineFilename#" or "%#StatusLineInactive#"
    local hl = "%#StatusLineFilename#"
    if not is_active then
        hl = "%#StatusLineInactive#"
    end
    return hl .. file, vim.fn.strdisplaywidth(file)
end

M.cursor = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local col = pos[2] + 1
    local row = pos[1]
    local corsor_str = string.format(" %s:%s ", row, col)
    return corsor_str, vim.fn.strdisplaywidth(corsor_str)
end

M.modified = function()
    -- 
    local mark = vim.o.modified and "[+]" or "[✔︎]"
    local count = modified_bg_bufs_count()
    if count ~= 0 then
        mark = mark .. " ([+" .. tostring(count) .. "])"
    end
    mark = " " .. mark .. " "
    return mark, vim.fn.strdisplaywidth(mark)
end

local bar = function(count, is_active)
    local hl = (function()
        local match = {
            normal = "%#StatusLineNormal#",
            visual = "%#StatusLineVisual#",
            insert = "%#StatusLineInsert#",
            replace = "%#StatusLineReplace#",
            command = "%#StatusLineCommand#",
        }
        return match[mode()] or "%#StatusLine#"
    end)()
    hl = is_active and hl or "%#StatusLineInactive#"
    -- if not is_active_win() then
    --     hl = "%#StatusLineInactive#"
    -- end
    return hl .. string.rep("─", count)
    -- return hl .. string.rep("━", count)
end

M.active_winbar = function()
    local window_width = vim.api.nvim_win_get_width(0)

    local modified, modified_width = M.modified()
    local filename, filename_width = M.filename(true)
    local cursor, cursor_width = M.cursor()
    local left_bar_width = math.floor((window_width - filename_width) / 2) - modified_width - 2
    local right_bar_width = math.ceil((window_width - filename_width) / 2) - cursor_width - 2

    return bar(1, true)
        .. modified
        .. bar(left_bar_width, true)
        .. filename
        .. bar(right_bar_width, true)
        .. cursor
        .. bar(1, true)
end

M.inactive_winbar = function()
    local window_width = vim.api.nvim_win_get_width(0)

    local modified, modified_width = M.modified()
    local filename, filename_width = M.filename(false)
    local cursor, cursor_width = M.cursor()
    local left_bar_width = math.floor((window_width - filename_width) / 2) - modified_width - 2
    local right_bar_width = math.ceil((window_width - filename_width) / 2) - cursor_width - 2

    return bar(1, false)
        .. modified
        .. bar(left_bar_width, false)
        .. filename
        .. bar(right_bar_width, false)
        .. cursor
        .. bar(1)
end

M.active_status = function()
    local branch = require("lualine.components.branch.git_branch").get_branch()
    return branch
end

return M
-- local M = {}
--
-- local fn = vim.fn
-- local highlight = require("rc.util").highlight
--
-- highlight.link({ StatusLine = "Normal" })
-- highlight.set({
-- 	StatusLineNormal = { fg = "#4caf50", bg = "NONE" },
-- 	StatusLineInsert = { fg = "#03a9f4", bg = "NONE" },
-- 	StatusLineVisual = { fg = "#ff9800", bg = "NONE" },
-- 	StatusLineReplace = { fg = "#ff5722", bg = "NONE" },
-- 	StatusLineCommand = { fg = "#8eacbb", bg = "NONE" },
-- })
--
-- ---@return string
-- local function mode()
-- 	local m = string.lower(vim.fn.mode())
-- 	if m == "n" then
-- 		return "normal"
-- 	elseif m == "i" then
-- 		return "insert"
-- 	elseif m == "c" then
-- 		return "command"
-- 	elseif m == "v" or m == "^V" or m == "s" then
-- 		return "visual"
-- 	elseif m == "r" then
-- 		return "replace"
-- 	end
-- 	return "other"
-- end
--
-- ---@return number
-- local function modified_bg_bufs_count()
-- 	local cnt = 0
-- 	for i = 1, fn.bufnr("$") do
-- 		if
-- 			fn.bufexists(i) == 1
-- 			and fn.buflisted(i) == 1
-- 			and fn.getbufvar(i, "buftype") == ""
-- 			and fn.filereadable(fn.expand("#" .. i .. ":p"))
-- 			and i ~= fn.bufnr("%%")
-- 			and fn.getbufvar(i, "&modified") == 1
-- 		then
-- 			cnt = cnt + 1
-- 		end
-- 	end
-- 	return cnt
-- end
--
-- local component = {
-- 	filePath = function()
-- 		local path = fn.fnamemodify(fn.expand("%"), ":~:.")
-- 		if path == "" then
-- 			return "", 0
-- 		end
-- 		path = " " .. path .. " "
-- 		return "%%#StatusLine#" .. path, fn.strdisplaywidth(path)
-- 	end,
-- 	modified = function()
-- 		local mark = vim.o.modified and "" or ""
-- 		local count = modified_bg_bufs_count()
-- 		if count ~= 0 then
-- 			mark = mark .. " ( " .. tostring(count) .. ")"
-- 		end
-- 		mark = " " .. mark .. " "
-- 		return "%%#StatusLine#" .. mark, fn.strdisplaywidth(mark)
-- 	end,
-- 	position = function()
-- 		local l = tostring(vim.fn.line("."))
-- 		local c = tostring(vim.fn.col("."))
-- 		local pos = " " .. l .. ":" .. c .. " "
-- 		return "%%#StatusLine#" .. pos, fn.strdisplaywidth(pos)
-- 	end,
-- }
--
-- ---@return string
-- function M.statusline()
-- 	local hl = (function()
-- 		local match = {
-- 			normal = "%%#StatusLineNormal#",
-- 			visual = "%%#StatusLineVisual#",
-- 			insert = "%%#StatusLineInsert#",
-- 			replace = "%%#StatusLineReplace#",
-- 			command = "%%#StatusLineCommand#",
-- 		}
-- 		return match[mode()] or "%%#StatusLine#"
-- 	end)()
-- 	local bar = function(count)
-- 		return hl .. string.rep("━", count)
-- 	end
--
-- 	local columnWidth = vim.o.columns
-- 	local file, fileWidth = component.filePath()
-- 	local modified, modifiedWidth = component.modified()
-- 	local pos, posWidth = component.position()
-- 	return bar(1)
-- 		.. modified
-- 		.. bar(math.floor((columnWidth - modifiedWidth - fileWidth - posWidth - 2) / 2))
-- 		.. file
-- 		.. bar(math.ceil((columnWidth - modifiedWidth - fileWidth - posWidth - 2) / 2))
-- 		.. pos
-- 		.. bar(1)
-- end
--
-- setmetatable(M, {
-- 	__call = function()
-- 		return M.statusline()
-- 	end,
-- })
--
-- return M
