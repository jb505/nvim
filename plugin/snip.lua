--[[
Author: James Beauford
Email: jbad505@gmail.com
Plugin Name: Snip
Description: Neovim plugin for saving snippets of text in
current path.
Version: 1.0
P.S.: Not the original plan... fuck it... it works!
--]]
-- Write yanked lines from reg to .snips file
function SnipYankedLinesToFile()
    -- Get the yanked lines from register
    local yanked_lines = vim.fn.getreg('0')

    -- Split the yanked lines into a table of strings
    local lines_table = vim.split(yanked_lines, "\n")

    -- Create a new buffer with the specified filename
    local file_path = vim.fn.expand('%:p:h') .. '/.snips'

    -- Open file in append mode - if not nil value write and close
    local snips_file = io.open(file_path, "a+")

    if snips_file ~= nil then
        for _, data in pairs(lines_table) do
            snips_file:write(data .. '\n')
        end
        snips_file:close()
    end
end

-- Open .snips file in new window
function ViewSnips()
    -- Create a new buffer with the specified filename
    local file_path = vim.fn.expand('%:p:h') .. '/.snips'
    local snips_file = io.open(file_path, "r")

    -- Check if file exists
    if snips_file ~= nil then
        -- Open a new split window
        vim.cmd('vnew')

        -- Get the current buffer number
        local current_buffer = vim.api.nvim_get_current_buf()

        -- Open the file in the new window
        vim.api.nvim_buf_call(current_buffer, function()
            vim.fn.setline(1, vim.fn.readfile(file_path))
        end)
        -- Set the buffer name to ".snips"
        vim.api.nvim_buf_set_name(current_buffer, '.snips')
    else
        print('No .snips file found.')
    end
end

-- Close .snips buffer without saving
function CloseSnipsBuffer()
    -- Get the buffer number by name
    local buffer_number = vim.fn.bufnr('.snips')

    -- Check if the buffer exists
    if buffer_number ~= -1 then
        -- Delete the buffer
        vim.api.nvim_buf_delete(buffer_number, { force = true })
    else
        print('No .snips buffer found.')
    end
end
