vim.filetype.add({
	pattern = { [".*/hypr.*/.*%.conf"] = "hyprlang", [".*kde.*"] = "kde" },
	extension = {
		bak = "backup",
		new = "backup",
	},
})
