local M = {}

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

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
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	local win_opts = {
		style = opts.style or "minimal",
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
	vim.api.nvim_create_user_command("TermFloating", function()
		if not vim.api.nvim_win_is_valid(state.floating.win) then
			opts.buf = state.floating.buf
			state.floating = create_floating_win(opts)
		else
			vim.api.nvim_win_hide(state.floating.win)
		end
	end, {})
end

return M
