local builtin = require('telescope.builtin')
-- Fuzzy find
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- Git files
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
-- File search
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
