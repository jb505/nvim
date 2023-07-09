-- Leader set to space
vim.g.mapleader = " "
-- Netrw (*-*)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Split window
vim.keymap.set("n", "<leader>|", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>-", vim.cmd.split)
-- Exit nvim
vim.keymap.set("n", "<C-x>", vim.cmd.exit)
-- Move highlight in visual mode up / down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Append bottom line to current line with a space
vim.keymap.set("n", "J", "mzJ`z")
-- Half page jump up / down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Search pattern stuff
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Umm... I don know... it was here...
vim.keymap.set("n", "<C-a>", "<C-w>")
-- Preserve current paste buffer
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Yank in normal or visual mode
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- INTO THE VOID!
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- Because we can...
vim.keymap.set("i", "<C-c>", "<Esc>")
-- Bruh...
vim.keymap.set("n", "Q", "<nop>")
-- This shit dont work.
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- Prev / next nav
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- Split window nav
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<CR>")
-- Replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Chmod +x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
