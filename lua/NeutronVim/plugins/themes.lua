return {
	{
		{ "tiagovla/tokyodark.nvim", priority = 1000, lazy = false },
		{ "folke/tokyonight.nvim", priority = 1000, lazy = false },
		{ "EdenEast/nightfox.nvim" },
		{ "catppuccin/nvim", name = "catppuccin" },
		{ "maxmx03/fluoromachine.nvim" },
		{ "projekt0n/github-nvim-theme", name = "github-theme" },
		{ "marko-cerovac/material.nvim" },
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		keys = { { "<C-P>", "<cmd>Themery<cr>", desc = "Theme setter" } },
		config = function()
			require("themery").setup({
				themes = {
					{
						name = "TokyoDay",
						colorscheme = "tokyonight-day",
						before = [[ vim.opt.background = "light" ]],
					},
					{
						name = "Github Light",
						colorscheme = "github_light",
						before = [[ vim.opt.background = "light" ]],
					},
					{
						name = "CatLatteDay",
						colorscheme = "catppuccin-latte",
						before = [[ vim.opt.background = "light" ]],
					},
					{
						name = "DayFox",
						colorscheme = "dayfox",
						before = [[ vim.opt.background = "light" ]],
					},
					{
						name = "MateriaLighter",
						colorscheme = "material",
						before = [[vim.opt.background="light"
                        vim.g.material_style = "lighter"
                     ]],
					},
					{
						name = "TokyoDark",
						colorscheme = "tokyodark",
						before = [[
                        vim.opt.background = "dark"
                        _require("tokyodark", "Error setting TokyoDark options").setup({
                          custom_palette = function(palette) return { bg0 = "#0A0C10" } end,
                        })
                     ]],
					},
					{
						name = "TokyoNight",
						colorscheme = "tokyonight-night",
						before = [[ vim.opt.background = "dark" ]],
					},
					{
						name = "CatMochaNight",
						colorscheme = "catppuccin-mocha",
						before = [[ 
                        vim.opt.background = "dark"
                        _require("catppuccin", "Error setting catpuccin options").setup({ flavour = "mocha" })
                     ]],
					},
					{
						name = "CatBlack",
						colorscheme = "catppuccin",
						before = [[
                        vim.opt.background = "dark"
                        _require("catppuccin", "Error setting catppuccin options").setup({
                          color_overrides = {
                            mocha = {
                              base = "#0A0C10",
                              mantle = "#0A0C10",
                              crust = "#0A0C10",
                            },
                          },
                        })
                     ]],
					},
					{
						name = "DuskFox",
						colorscheme = "duskfox",
						before = [[ vim.opt.background = "dark" ]],
					},
					{
						name = "NightFox",
						colorscheme = "nightfox",
						before = [[ vim.opt.background = "dark" ]],
					},
					{
						name = "FluoroMachine",
						colorscheme = "fluoromachine",
						before = [[
                        vim.opt.background = "dark"
                        _require("fluoromachine", "Error setting fluoromachine options").setup({
                          glow = true,
                          colors = function(_, color)
                            local darken = color.darken
                            return {
                              bg = '#190920',
                              bgdark = darken('#190920', 20)
                            }
                          end
                        })
                     ]],
					},
					{
						name = "MaterialDeep",
						colorscheme = "material",
						before = [[vim.opt.background="dark"
                        vim.g.material_style = "deep ocean"
                     ]],
					},
					{ name = "Default", colorscheme = "default" },
				},
			})
		end,
	},
}
