local pending = require('pending')

local function getTable(myTable)
	local results = {}
	for _, value in ipairs(myTable) do
		local title = "Title: " .. value['title']
		local description = "Description: " .. value['description']
		local seperator = " "
		table.insert(results, title)
		table.insert(results, description)
		table.insert(results, seperator)
	end
	return results
end

-- Function to open a file in a floating buffer
local function openPending()
	-- Create a new buffer
	local bufnr = vim.api.nvim_create_buf(false, true)

	-- Open the buffer in a floating window
	local width = 0.5
	local height = 0.5
	local row = math.floor(((1 - height) / 2) * vim.o.lines)
	local col = math.floor(((1 - width) / 2) * vim.o.columns)

	-- Build window
	local win = vim.api.nvim_open_win(bufnr, true, {
		relative = "editor",
		row = row,
		col = col,
		width = math.floor(width * vim.o.columns),
		height = math.floor(height * vim.o.lines),
		style = "minimal",
		border = "rounded",
		title = "Pending"
	})

	-- Read the file content and set it in the buffer
	local pending_table = getTable(pending)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, pending_table)
end

local function addPending ()
	-- Get input
	-- Append input to pedning.lua
end

openPending()
