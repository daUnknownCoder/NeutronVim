return {
	{ "nvim-lua/plenary.nvim", lazy = false },
	{
		"echasnovski/mini.icons",
		version = false,
		lazy = false,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				_require("mini.icons", "Couldn't mock nvim-web-devicons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
			_require("mini.icons", "Error setting up icons").setup(require("NeutronVim.plugins.configs.icons"))
		end,
	},
}
