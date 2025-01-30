local map = vim.keymap.set
vim.g.mapleader = " "

-- modes = {
-- 	normal_mode = "n",
-- 	insert_mode = "i",
-- 	visual_mode = "v",
-- 	visual_block_mode = "x",
-- 	term_mode = "t",
-- 	command_mode = "c",
-- }

--> Better Next and previous search
map("n", "n", "nzzzv", { noremap = true, silent = true })
map("n", "N", "Nzzzv", { noremap = true, silent = true })

--> Better `j` and `k`
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

--> Resize with <ctrl>+arrow-keys
map("n", "<C-Up>", ":resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<cr>", { desc = "Increase window width" })

--> Move to [first/last] character at [beginning/end] of line
map({ "n", "x" }, "H", function()
	return vim.v.count > 0 and "^" or "g^"
end, { desc = "Move to first character", silent = true, expr = true })
map({ "n", "x" }, "L", function()
	return vim.v.count > 0 and "$" or "g$"
end, { desc = "Move to last character", silent = true, expr = true })

--> Move text up and down [in all modes] with `J` and `K`
map("n", "J", ":m .+1<cr>==", { desc = "Move down", silent = true })
map("n", "K", ":m .-2<cr>==", { desc = "Move up", silent = true })
map("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down", silent = true })
map("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up", silent = true })
map({ "v", "x" }, "J", ":m '>+1<CR>gv=gv", { desc = "Move down", silent = true })
map({ "v", "x" }, "K", ":m '<-2<CR>gv=gv", { desc = "Move up", silent = true })

--> Keep the cursor in place while joining lines
map("n", "<leader>j", "mzJ`z", { desc = "Join lines and keep cursor in place", silent = true })

--> FZF style ? / search
map("c", "<space>", function()
	local mode = vim.fn.getcmdtype()
	if mode == "?" or mode == "/" then
		return ".*"
	else
		return " "
	end
end, { expr = true })

--> Cycling through pages with <C-u> and <C-d>
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

--> Clear search
map("n", "<esc>", ":noh<cr><esc>", { desc = "Escape and clear hlsearch", silent = true })

--> Don't lose selection when shifting sidewards
map("x", "<", "<gv", { desc = "Dont lose selection when shifting left", silent = true })
map("x", ">", ">gv", { desc = "Dont lose selection when shifting right", silent = true })
map("n", ">", ">>", { desc = "Shifting right direct", silent = true })
map("n", "<", "<<", { desc = "Shifting right direct", silent = true })

--> Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

--> Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file", silent = true })

--> Delete God Mode
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete in the God-mode", silent = true })

--> Delete Empty lines without writing to clipboard
map("n", "dd", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end, { expr = true, desc = "Delete empty lines without writing to registers", silent = true })

--> Exit insert mode
map("i", "<C-c>", "<Esc>")

--> Replace
map("n", "<leader><leader>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Better Replace" })

--> Change permissions
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

--> Better count o/O
map("n", "o", function()
	return "m`" .. vim.v.count .. "o<Esc>i" .. string.rep("\t", #(vim.fn.getline("."):match("^\t*") or ""))
end, { expr = true, desc = "Insert lines with proper indentation and cursor placement" })
map("n", "O", function()
	return "m`" .. vim.v.count .. "O<Esc>" .. string.rep("\t", #(vim.fn.getline("."):match("^\t*") or ""))
end, { expr = true, desc = "Insert lines with proper indentation and cursor placement" })

--> windows
map("n", "\\<Left>", "<C-w>h", { desc = "Focus Split [Left]", silent = true })
map("n", "\\<Down>", "<C-w>j", { desc = "Focus Split [Down]", silent = true })
map("n", "\\<Up>", "<C-w>k", { desc = "Focus Split [Up]", silent = true })
map("n", "\\<Right>", "<C-w>l", { desc = "Focus Split [Right]", silent = true })
map("n", "<C-h>", "<C-w>h", { desc = "Focus Split [Left]", silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Split [Down]", silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Split [Up]", silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Split [Right]", silent = true })
map("n", "\\l", "<C-w>v", { desc = "Split Horizontal", silent = true })
map("n", "\\j", "<C-w>s", { desc = "Split Vertical", silent = true })
map("n", "\\-", "<C-w>v", { desc = "Split Horizontal", silent = true })
map("n", "\\+", "<C-w>s", { desc = "Split Vertical", silent = true })
map("n", "\\=", "<C-w>=", { desc = "Equalize Split Size", silent = true })
map("n", "\\\\", "<C-W>c", { desc = "Delete Focused Split", remap = true, silent = true })
map("n", "\\/", "<cmd>only<cr>", { desc = "Delete all UnFocused Split", remap = true, silent = true })

--> Source the current lua file
map("n", "<leader>S", function()
	if vim.bo.filetype == "lua" then
		vim.cmd("source")
	else
		vim.api.nvim_echo({
			{ "Skipped sourcing, not a `lua` file.", "WarningMsg" },
		}, true, {})
	end
end, { desc = "Source current Lua file", silent = true })

--> Terminal
map("t", "<esc>", "<C-\\><C-n>", { desc = "Terminal escape", silent = true })

--> AutoIndent to appropriate position
map("n", "i", function()
	local line = vim.fn.getline(".")
	local col = vim.fn.col(".")
	local is_empty = #line == 0
	local is_leading_whitespace = col <= #line:match("^%s*")

	if is_empty then
		return '"_cc'
	elseif is_leading_whitespace then
		return "A"
	else
		return "i"
	end
end, { desc = "Automatically indent to the appropriate position", silent = true, expr = true })

--> Go to insert without copying to register from visual selection
map("v", "i", function()
	if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
		return '"_c'
	else
		vim.api.nvim_feedkeys("i", "n", true)
	end
end, { desc = "Goto insert without copying to register", silent = true, expr = true, noremap = true })

--> Go to insert and copy to register from visual selection
map("v", "I", function()
	if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
		return "c"
	else
		vim.api.nvim_feedkeys("I", "n", true)
	end
end, { desc = "Goto insert with copying to register", silent = true, expr = true, noremap = true })

--> Delete comments in line [normal and visual]
--> Helper function to detect file type and get the appropriate patterns
local function get_comment_patterns()
	local ft = vim.bo.filetype
	-- Define a table of comment patterns for different file types
	local comment_patterns = {
		lua = { whole_line = "^%s*%-%-(.*)$", inline = "(.-)%s*%-%-(.*)$" },
		python = { whole_line = "^%s*#(.*)$", inline = "(.-)%s*#(.*)$" },
		hyprlang = { whole_line = "^%s*#(.*)$", inline = "(.-)%s*#(.*)$" },
		fish = { whole_line = "^%s*#(.*)$", inline = "(.-)%s*#(.*)$" },
		cpp = { whole_line = "^%s*//(.*)$", inline = "(.-)%s*//(.*)$" },
		c = { whole_line = "^%s*//(.*)$", inline = "(.-)%s*//(.*)$" },
	}
	return comment_patterns[ft] or comment_patterns.python -- Default to Lua if the file type is not listed
end

--> Normal mode mapping
map("n", "<leader>c", function()
	local patterns = get_comment_patterns()
	local start_line = vim.fn.line(".")
	local end_line = start_line
	local comment_pattern = patterns.inline
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	for i, line_content in ipairs(lines) do
		local uncommented_line = line_content:gsub(comment_pattern, "%1")
		lines[i] = uncommented_line
	end
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end, { desc = "Remove comments from line", silent = true, noremap = true })

--> Visual mode mapping
map("v", "<leader>c", function()
	local patterns = get_comment_patterns()
	local start_line = vim.fn.line(".")
	local end_line = vim.fn.line("v")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end
	local whole_line_comment_pattern = patterns.whole_line
	local inline_comment_pattern = patterns.inline
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	for i, line_content in ipairs(lines) do
		if line_content:match(whole_line_comment_pattern) then
			lines[i] = ""
		else
			local uncommented_line = line_content:gsub(inline_comment_pattern, "%1")
			lines[i] = uncommented_line
		end
	end
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end, { desc = "Remove comments from selected lines", silent = true, noremap = true })

--> Run shell script [normal,visual]
map("n", "<leader><cr>", "yyo<ESC>kpV:!/bin/bash<CR>", { desc = "Run in Bash and print output" })
map("v", "<leader><cr>", "y'<kp'<O<ESC>'>:<C-u>'<,'>!/bin/bash<CR>", { desc = "Run in Bash and print output" })

--> Increment/Decrement with +/-
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })
map("v", "+", "<C-a>gv", { desc = "Increment number" })
map("v", "-", "<C-x>gv", { desc = "Decrement number" })

--> Toggle hlsearch if it's on, otherwise just do "enter"
map("n", "<CR>", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.v.hlsearch == 1 then
		vim.cmd.nohl()
	else
		return vim.keycode("<CR>")
	end
end, { expr = true })

--> Paste with <C-v>
map({ "i", "c" }, "<C-v>", "<C-r>+", { desc = "Paste with <C-v>" })
map({ "n", "v" }, "<C-v>", "p", { desc = "Paste with <C-v>" })

--> Open file from register
map("n", "<C-f>", [[:e <C-r>a<CR>]], { desc = "Open file from `a` register", noremap = true, silent = true })

--> Code Block copy like markdown
map(
	{ "n", "v" },
	"<C-c>",
	[[:CopyCodeBlock<CR>]],
	{ desc = "Copy markdown type Code Block with current filetype in backticks", noremap = true, silent = true }
)

--> Quit nvim/delete current buffer
map("n", "<C-q>", function()
	if vim.bo.modified then
		print("Buffer modified! <C-S> to save file")
		return
	end
	local total = #vim.tbl_filter(function(buf)
		return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= ""
	end, vim.api.nvim_list_bufs())

	local quit_cmd = #vim.api.nvim_list_wins() > 1 and "Q" or "q"
	vim.cmd(total == 1 and quit_cmd or "bd")
end, { desc = "Quit Nvim/Buffer Delete", noremap = true })

--> Better Escape?
map("i", "jk", "<ESC>", { desc = "Escape insert mode ez" })
