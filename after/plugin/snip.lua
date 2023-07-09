-- These key mappings are shit... TODO: Fix this!!!
vim.api.nvim_set_keymap('n', '<leader>pl', ':lua SnipYankedLinesToFile()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>of', ':lua ViewSnips()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cf', ':lua CloseSnipsBuffer()<CR>', { noremap = true, silent = true })
