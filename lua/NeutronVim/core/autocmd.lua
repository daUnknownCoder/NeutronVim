--> Set main options
_autocmd("User", "VeryLazy", function()
	vim.cmd("filetype plugin indent on")
	vim.cmd("syntax on")
end, "set_opts", true)

--> Automagically close command-line window.
_autocmd("CmdWinEnter", "*", function()
	vim.cmd("quit")
end, "autoclose_cmdline_window")

--> Check if we need to reload the file when it changed
_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained", "TermClose", "TermLeave" }, "*", function()
	if vim.bo.buftype ~= "nofile" and vim.fn.mode() ~= "c" then
		vim.cmd("checktime")
	end
end, "check_if_wanna_reload")

--> Resize splits if window got resized
_autocmd("VimResized", "*", function()
	vim.cmd("tabdo wincmd =")
end, "resize_splits")

--> Highlight on yank
_autocmd("TextYankPost", "*", function()
	(vim.hl or vim.highlight).on_yank()
end, "highlight_on_yank")

--> CSV settings
_autocmd({ "BufRead", "BufNewFile" }, "*.csv", function()
	vim.bo.filetype = "csv"
	vim.wo.wrap = false
	vim.bo.textwidth = 0
end, "csv_settings")

--> Format options
_autocmd("FileType", "*", function()
	-- Add these options.
	vim.bo.formatoptions = vim.bo.formatoptions .. "jnqt"
	-- Remove these options.
	vim.bo.formatoptions = vim.bo.formatoptions:gsub("[2cor]", "")
end, "format_options")

--> Auto create dir when saving a file, in case some intermediate directory does not exist
_autocmd("BufWritePre", "*", function(event)
	local file = event.match
	if
		not (vim.api.nvim_buf_is_valid(event.buf or 0) and vim.bo[event.buf or 0].buflisted)
		or file:match("^%w+:[\\/][\\/]")
	then
		return
	end
	vim.fn.mkdir(vim.fn.fnamemodify((vim.uv or vim.loop).fs_realpath(file) or file, ":p:h"), "p")
end, "auto_create_dir")

--> Go to last location when opening a buffer
_autocmd({ "BufReadPost", "BufEnter", "BufWinEnter" }, "*", function(event)
	vim.defer_fn(function()
		local exclude = { "gitcommit", "gitrebase" }
		local buf = event.buf
		local cursor_pos = vim.api.nvim_buf_get_mark(0, '"')
		local line = cursor_pos[1]
		local last_line = vim.api.nvim_buf_line_count(0)
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].NeutronVim_go_to_last_loc then
			return
		end
		vim.b[buf].NeutronVim_go_to_last_loc = true
		if line > 0 and line <= last_line then
			if vim.api.nvim_buf_line_count(0) == vim.fn.line("w$") then
				pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
			elseif vim.api.nvim_buf_line_count(0) - line > ((vim.fn.line("w$") - vim.fn.line("w0")) / 2) - 1 then
				pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
				vim.cmd("norm! zz")
			else
				pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<c-e>", true, false, true), "n", false)
			end
		end
	end, 10)
end, "go_to_last_loc", true)

--> JSON syntax match
_autocmd({ "BufRead", "BufNewFile" }, "*.json", function()
	vim.cmd([[syntax match Comment +\/\/.\+$+]])
end, "json_syntax")

--> Remove trailing WhiteSpace
_autocmd("BufWritePre", "*", function()
	vim.cmd([[%s/\s\+$//e]])
end, "remove_trailing_whitespace")

--> Highlight text after `-->`
_autocmd("BufReadPost", "*.lua", [[call matchadd("Keyword", "--> \\zs.*\\ze$")]], "highlight_after_arrow")

--> Terminal Options
_autocmd("TermOpen", "term://*", "setl nonu nornu nospell scl=no | star", "terminal_options")

--> QuickFix on bottom
_autocmd("FileType", "qf", function()
	vim.cmd([[ wincmd J | setl nobuflisted ]])
end, "quickfix_on_bottom")

--> close all notifications before writing
-- _autocmd("BufWritePre", "*", function()
-- 	require("notify").dismiss({ pending = true, silent = true })
-- end, "close_notif_b4_writing")

--> Cool command for copying github style code block
vim.api.nvim_create_user_command("CopyCodeBlock", function(opts)
	local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
	local content = table.concat(lines, "\n")
	local result = string.format("```%s\n%s\n```", vim.bo.filetype, content)
	local success = pcall(vim.fn.setreg, "+", result)
	if success then
		vim.notify("Text copied to clipboard")
	else
		vim.notify("Failed to copy text to clipboard")
	end
end, { range = true })

--> Disable things in Dashboard
_autocmd("FileType", "*", function()
	if vim.bo.filetype == "dashboard" then
		vim.cmd([[silent! setl nonu nornu nobl acd ft=dashboard bh=wipe bt=nofile]])
	end
end, "dashboard_no_things")

--> Set Spell on lazy load
_autocmd("User", "VeryLazy", function()
	vim.opt_global.spell = true
	vim.opt.spelllang = { "en_us" }
	return true
end, "set_spell")

--> Close all floating windows before exiting Neovim
_autocmd("VimLeavePre", "*", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end, "close_floats")

--> Load view
_autocmd("BufWinEnter", "*", function(args)
	if not vim.b[args.buf].view_activated then
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
		local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
		if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
			vim.b[args.buf].view_activated = true
			vim.cmd.loadview({ mods = { emsg_silent = true } })
		end
	end
end, "load_view")

--> Clear Search on Write
_autocmd("BufWritePost", "*", function()
	vim.schedule(function()
		vim.cmd("noh")
	end)
end, "clear_search")

--> LSP Related
_autocmd("BufWritePre", "*.rs,*.svelte", function()
	vim.lsp.buf.format()
end, "format_b4_write")
-- autocmd("CursorHold", "*", function() vim.diagnostic.open_float() end,"open_on_cursorhold")
_autocmd("FileType", "json,jsonc,http,markdown", "set cole=0", "conceallevel_ft")
_autocmd("FileType", "norg", "set scl=yes:4 nonu nornu", "norg_opts")

--> -- User Events
-- _autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, "*", function(args)
-- 	local empty_buffer = vim.fn.resolve(vim.fn.expand("%")) == ""
-- 	local greeter = vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "alpha"
-- 	local git_repo = require("NeutronVim.core.utils").run_cmd(
-- 		{ "git", "-C", vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("%")), ":p:h"), "rev-parse" },
-- 		false
-- 	)
--
-- 	if not (empty_buffer or greeter) then
-- 		require("NeutronVim.core.utils").trigger_event("User NeutroFile")
--
-- 		if git_repo then
-- 			require("NeutronVim.core.utils").trigger_event("User NeutroGitFile")
-- 		end
-- 	end
-- end, "user_event")
--
-- _autocmd({ "VimEnter" }, "*", function()
-- 	if #vim.fn.argv() >= 1 then
-- 		require("NeutronVim.core.utils").trigger_event("User NeutroDefered", true)
-- 		require("NeutronVim.core.utils").trigger_event("BufEnter", true)
-- 	else
-- 		vim.defer_fn(function()
-- 			require("NeutronVim.core.utils").trigger_event("User NeutroDefered")
-- 		end, 70)
-- 	end
-- end, "user_event")
--
-- -- URL highlight
-- vim.api.nvim_set_hl(0, "HighlightURL", { underline = true, default = true })
-- _autocmd("ColorScheme", "*", function()
-- 	vim.api.nvim_set_hl(0, "HighlightURL", { default = true, underline = true })
-- end, "url_highlight", false)
-- _autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, "*", function(args)
-- 	for _, win in ipairs(vim.api.nvim_list_wins()) do
-- 		if vim.api.nvim_win_get_buf(win) == args.buf and not vim.w[win].highlighturl_enabled then
-- 			_require("NeutronVim.core.utils", "Couldn't Import Utilities").set_url_match(win)
-- 		end
-- 	end
-- end, "url_highlight", false)
