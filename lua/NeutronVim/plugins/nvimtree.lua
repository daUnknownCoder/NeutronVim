return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeFindFileToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFindFile" },
	version = "*",
	lazy = false,
	dependencies = {
		{ "b0o/nvim-tree-preview.lua", lazy = true },
	},
	keys = {
		{ "<C-n>", "<cmd>NvimTreeFindFileToggle<cr>", desc = "NvimTree" },
	},
}
