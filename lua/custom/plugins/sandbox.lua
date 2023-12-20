local function get_current_buf_name()
	local buf_name = vim.api.nvim_buf_get_name(0)
	return buf_name
end

local function get_win_size()
	local win_height = vim.api.nvim_win_get_height(0)
	local win_width = vim.api.nvim_win_get_width(0)
	return win_height, win_width
end
-- buf_name = vim.fn.expand('%:p', get_current_buf_name())

--[[
 Note: to directly initiate the terminal using the right size, display the
 buffer in a configured window before calling this. For instance, for a
 floating display, first create an empty buffer using |nvim_create_buf()|,
 then display it using |nvim_open_win()|, and then call this function. Then
 |nvim_chan_send()| can be called immediately to process sequences in a
 virtual terminal having the intended size.
--]]

local function open_terminal_buf()
	local bufnr = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_open_win(bufnr, true,
		{ relative = 'editor', width = 157, height = 17, row = 42, col = 0, style = 'minimal', border = 'single', bufpos = { 100, 10 } })
	vim.cmd('terminal')
end

-- 41 157
-- Function to automatically switch to insert mode when entering a new buffer window
local function autoInsertMode()
	vim.cmd([[autocmd WinEnter * if &filetype != 'help' && &filetype != 'nerdtree' | startinsert | endif]])
end

-- Define a function to display a message when entering a buffer named "terminal"
function TerminalMessage()
	local bufname = vim.fn.bufname()
	if bufname and vim.fn.fnamemodify(bufname, ":t") == "terminal" then
		vim.api.nvim_out_write("Entering a terminal buffer!\n")
	end
end

-- Create a custom command that calls the TerminalMessage function
vim.cmd("command! TerminalMessage lua TerminalMessage()")

-- Automatically execute TerminalMessage when entering a buffer
vim.cmd("autocmd BufEnter * lua TerminalMessage()")

function OpenNetrw()
	-- Open Netrw in a vertical split on the left
	vim.cmd('vsplit wincmd L')

	-- Resize the Netrw window
	vim.cmd('vertical resize 20')

	-- Open Netrw
	vim.cmd('Explore')

	-- Disable line numbers in Netrw
	vim.cmd('wincmd W')
end

function GetFilePathUnderCursor()
	-- Get the path of the file under the cursor
	local file_path = vim.fn.expand('%:p')

	-- Print the file path to the command-line
	print("File path under cursor: " .. file_path)
end

-- Map a key (F8 in this case) to execute the function
-- vim.api.nvim_set_keymap('n', '<F9>', '<cmd>lua GetFilePathUnderCursor()<CR>', { noremap = true, silent = true })

local winid = vim.api.nvim_get_current_win()
vim.wo[winid].number = true -- same as vim.wo.number = true
-- print(winid)
-- print(vim.wo.foldmarker)
-- Winrn = vim.api.nvim_get_current_win()
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")

local opts = {
	finder = finders.new_table {
		"Task 1",
		"Task 2",
		"Task 3"
	},
	sorter = sorters.get_generic_fuzzy_sorter({}),
}


local pending_col = pickers.new(opts, {})
-- pending_col:find()


local function pending()
	-- Gotta get buff!
	local new_buffer = vim.api.nvim_create_buf(true, false)
	local buffer_num = vim.fn.bufnr(new_buffer, true)
	-- Window options
	local opts = {
		title = ' Pending Tasks ¯\\_(ツ)_/¯ ',
		title_pos = 'center',
		relative = 'editor',
		width = 50,
		height = 17,
		row = 10,
		col = 50,
		style = 'minimal',
		border = 'single',
		bufpos = { 100, 10 }
	}
	-- Open fancy floaty float window
	vim.api.nvim_open_win(buffer_num, true, opts)
end

local pending = require('pending')

function iterate_over_table(myTable)
	if type(myTable) == "table" then
		for _, entry in ipairs(myTable) do
			if type(entry) == "table" then
				for key, value in pairs(entry) do
					print(key, value)
				end
			end
		end
	else
		print("Error: Input is not a table.")
	end
end

-- Function to open a file in a floating buffer
function open_file_in_floating_buffer(file_path)
	-- Create a new buffer
	local bufnr = vim.api.nvim_create_buf(false, true)

	-- Open the buffer in a floating window
	local width = 0.5
	local height = 0.5
	local row = math.floor(((1 - height) / 2) * vim.o.lines)
	local col = math.floor(((1 - width) / 2) * vim.o.columns)

	local win_id = vim.api.nvim_open_win(bufnr, true, {
		relative = "editor",
		row = row,
		col = col,
		width = math.floor(width * vim.o.columns),
		height = math.floor(height * vim.o.lines),
		style = "minimal",
		border = "rounded",
	})

	-- Read the file content and set it in the buffer
	local file_content = vim.fn.readfile(file_path)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, file_content)

	-- Set the filetype based on the file extension
	local file_type = vim.fn.fnamemodify(file_path, ":e")
	vim.api.nvim_buf_set_option(bufnr, "filetype", file_type)

	-- Set the window title to the file name
	-- vim.api.nvim_win_set_option(win_id, 'title', file_path)

	-- Make the buffer and window modifiable
	vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
	-- vim.api.nvim_win_set_option(win_id, "modifiable", true)

	-- Set the buffer to read-only if needed
	vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

	-- Set the buffer to autocommands to close the window when the buffer is wiped out
	vim.cmd([[autocmd BufWipeout <buffer> exe 'bwipeout!']])
end

-- local file_content = vim.fn.readfile(file_path)
-- Example usage:
-- open_file_in_floating_buffer("/home/jb/.config/nvim/lua/custom/plugins/sandbox.lua")

-- Wrtie to json Function
-- local function pending(value)
-- 	json_file = vim.fn.readfile('/home/jb/.config/nvim/lua/custom/plugins/pending.lua')
-- 	return json_file.value
-- end
-- local myTable = require("pending")
-- function iterate_over_table(myTable)
--     if type(myTable) == "table" then
--         for _, entry in ipairs(myTable) do
--             if type(entry) == "table" then
--                 for key, value in pairs(entry) do
--                     print(key, value)
--                 end
--             end
--         end
--     else
--         print("Error: Input is not a table.")
--     end
-- end
-- local function print_nested_table(table)
-- 	P(table)
-- 	if type(table) == "table" then
-- 		print("Entering 1st if")
-- 		print(type(table))
-- 		for _, entry in pairs(table) do
-- 			print("Entering 1st for loop")
-- 			print(type(_))
-- 			if type(entry) == "table" then
-- 				print("Entering 2nd if")
-- 				print(type(_))
-- 				for key, value in pairs(entry) do
-- 					print("Entering 2nd for")
-- 					print(key, value)
-- 				end
-- 			end
-- 		end
-- 	end
-- end
-- print_nested_table(myTable)
-- Neovim Lua function to iterate over a table with nested tables

--- Example usage:
-- local myTable = {
-- 	{
-- 		id = 1,
-- 		name = "name1",
-- 	},
-- 	{
-- 		id = 2,
-- 		name = "name2",
-- 	},
-- 	{
-- 		id = 3,
-- 		name = "name3",
-- 	}
-- }

iterate_over_table(pending)
