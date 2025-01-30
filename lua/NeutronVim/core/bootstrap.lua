vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local icons = _require("NeutronVim.plugins.configs.icons")

--> Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	if vim.fn.executable("git") == 0 then
		vim.fn.getchar()
		os.exit(1)
	end
	print("Bootstrapping lazy.nvim...")
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- stylua: ignore
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	-- Error if lazy wasn't installed properly
	if vim.api.nvim_get_vvar("shell_error") ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		vim.opt.cmdheight = 1
		os.exit(1)
	end
	vim.notify("Please wait while plugins are installed...")
	-- _autocmd("User", "LazyInstall", function()
	-- 	vim.cmd.bw()
	-- 	vim.tbl_map(function(module)
	-- 		_require(module)
	-- 	end, { "nvim-treesitter", "mason" })
	-- 	vim.notify("Mason is installing packages if configured, check status with `:Mason`")
	-- end, "Mason_Treesitter_install")
end
vim.opt.rtp:prepend(lazypath)

--> Setup lazy.nvim
_require("lazy").setup({
	spec = {
		{ "daUnknownCoder/essentials.nvim", branch = "patch-1" },
		{ import = "NeutronVim.plugins" },
	},
	install = {
		colorscheme = { "tokyonight", "habamax" },
	},
	defaults = {
		lazy = true,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	ui = {
		border = "rounded",
		title = icons.ui.electric.glyph .. " La" .. icons.ui.sleep.glyph .. "y " .. icons.ui.electric.glyph,
		ui = {
			icons = {
				ft = "",
			},
		},
	},
	rocks = { enabled = vim.fn.executable("luarocks") == 1 },
})
