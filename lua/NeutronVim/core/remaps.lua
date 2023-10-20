local map = vim.keymap.set
vim.g.mapleader = " "

-- Better `j` and `k`
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Resize with <ctrl>+arrow-keys
map("n", "<C-Up>", ":resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<cr>", { desc = "Increase window width" })

-- Move text up and down [in all modes] with `J` and `K`
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move up" })
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Keep the cursor in place while joining lines
map("n", "<leader>J", "mzJ`z", { desc = "Join lines and keep cursor in place" })

-- Cycling through pages with <C-u> and <C-d>
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Next and previous search
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Clear search
map("n", "<esc>", ":noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Better Yank to clipboard
map("v", "<leader>yy", [["+y]], { desc = "Yank to clipboard" })
map("n", "<leader>yY", [["+Y]], { desc = "Yank to clipboard" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file like notepad" })

-- Lazy
map("n", "<leader>p", ":Lazy<cr>", { desc = "Lazy" })

-- Delete's God-mode
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete in the God-mode" })

-- Exit insert mode
map("i", "<C-c>", "<Esc>")

-- Replace
map({ "n", "v" }, "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Better Replace" })

-- change permissions
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- windows
map("n", "<leader>w*", "<C-W><C-W>", { desc = "Next Part of window" })
map("n", "<leader>w/", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w+", "<C-W>v", { desc = "Split window right", remap = true })

-- Source the current file
map("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source current Lua file" })
