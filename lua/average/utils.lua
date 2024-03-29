--[[
  Gang gang! Utils gang!!
  Purpose: Utility / Helper functions
  to do stuff.
--]]

-- For plugin devel
P = function(v)
  print(vim.inspect(v))
  return v
end

-- Floating Terminal Window
function OpenTerminal()
  -- Gotta get buff!
  local new_buffer = vim.api.nvim_create_buf(true, false)
  local buffer_num = vim.fn.bufnr(new_buffer, true)
  -- Window options
  local opts = {
    title = ' ¯\\_(ツ)_/¯ ',
    title_pos = 'left',
    relative = 'editor',
    width = 157,
    height = 17,
    row = 42,
    col = 0,
    style = 'minimal',
    border = 'single',
    bufpos = { 100, 10 }
  }
  -- Open fancy floaty float window
  vim.api.nvim_open_win(buffer_num, true, opts)
  -- Because this is so much easier to do
  -- and it just works.
  vim.cmd('terminal')
  vim.cmd('startinsert')
end

-- Make Netrw pretty!
function OpenNetrw()
  -- Open Netrw in a vertical split on the left
  vim.cmd('vsplit wincmd L')
  -- Resize the Netrw window
  vim.cmd('vertical resize 20')
  -- Open Netrw
  vim.cmd('Explore')
end
