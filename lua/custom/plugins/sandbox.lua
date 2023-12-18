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
