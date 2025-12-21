local M = {}

local function create_floating_win(opts)
	local opts = opts or {}

	local ui = vim.api.nvim_list_uis()[1]
	local screen_w = ui.width
	local screen_h = ui.height

	local win_w = opts.win_w or math.ceil(screen_w * 0.8)
	local win_h = opts.win_h or math.ceil(screen_h * 0.8)

	local col = math.floor((screen_w - win_w) / 2)
	local row = math.floor((screen_h - win_h) / 2)

	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true)

	local win_opts = {
		style = "minimal",
		relative = "editor",
		width = win_w,
		height = win_h,
		row = row,
		col = col,
		border = opts.border or "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_opts)

	return { buf = buf, win = win }
end

function M.setup(opts)
	opts = opts or {}
end

return M
