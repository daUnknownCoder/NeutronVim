local keymap = vim.keymap.set

vim.g.mapleader = " "
keymap("n", "<leader>pv", ":NvimTreeFindFileToggle")

keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- greatest remap ever
keymap("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
keymap("v", "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])

keymap({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
keymap("i", "<C-c>", "<Esc>")

keymap("n", "<leader>f", vim.lsp.buf.format)

keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap({ "n", "v" }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


keymap("n", "<leader><leader>", function()
    vim.cmd("so")
end)
keymap("n", "`", "<C-w><C-w>")
