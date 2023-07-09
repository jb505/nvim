-- These key mappings are shit... TODO: Fix this!!!
vim.api.nvim_set_keymap('n', '<leader>sp', ':lua SnipYankedLinesToFile()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', ':lua ViewSnips()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sc', ':lua CloseSnipsBuffer()<CR>', { noremap = true, silent = true })
