local M = {}
M.highlight = {}

---@param hls table
---@return nil
function M.highlight.set(hls)
	for group, value in pairs(hls) do
		vim.api.nvim_set_hl(0, group, value)
	end
end

---@param links table
---@return nil
function M.highlight.link(links)
	for from, to in pairs(links) do
		vim.api.nvim_set_hl(0, from, {
			link = to,
		})
	end
end

return M
