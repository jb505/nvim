--[[
  Gang gang! utils gang!!
  Purpose: Utility / Helper functions
  to do stuff.
--]]

-- For plugin devel
P = function(v)
  print(vim.inspect(v))
  return v
end

-- Floating terminal window
function Open_Terminal()
  -- Gotta get buff!
  local new_buffer = vim.api.nvim_create_buf(true, false)
  local buffer_num = vim.fn.bufnr(new_buffer, true)
  -- Dis whole table ops!
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

function OpenNetrw()
  -- vim.api.nvim_set_var('netrw_winsize', 85)
  -- vim.api.nvim_set_var('netrw_browse_split', Winrn)
  Winrn = vim.api.nvim_get_current_win()
  -- Open Netrw in a vertical split on the left
  vim.cmd('vsplit wincmd L')

  -- Resize the Netrw window
  vim.cmd('vertical resize 20')

  -- Open Netrw
  vim.cmd('Explore')

  vim.cmd('wincmd W')
end
