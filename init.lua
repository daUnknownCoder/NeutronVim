if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
	vim.loader.enable()
end

--> Safely call modules
---@param module_name string Name of the module to be required
---@param error? string Custom error message (optional)
---@return boolean|function|string[]
---@type function
_G._require = function(module_name, error)
	local package_exists, module = pcall(require, module_name)
	if not package_exists then
		vim.defer_fn(function()
			vim.schedule(function()
				vim.notify(
					(error and " " .. error or (' Error loading module "' .. module_name .. '"')),
					vim.log.levels.ERROR,
					{ title = "Module Not Found" }
				)
			end)
		end, 50)
		return module
	else
		return module
	end
end

--> Generate augroup
---@param name string Name of the augroup
---@type function
_G._augroup = function(name)
	return vim.api.nvim_create_augroup("NeutronVim_" .. name, { clear = true })
end

--> Create autocmd
---@param events string|string[] Event(s) for the autocommand
---@param ptn string Pattern to match
---@param cb function|string Callback function or command
---@param group? string|nil Autocommand group name (optional)
---@param once? boolean|nil Whether the autocommand should be triggered only once (optional)
---@type function
_G._autocmd = function(events, ptn, cb, group, once)
	local cmd = { pattern = ptn, [type(cb) == "function" and "callback" or "command"] = cb }
	if group then
		cmd.group = _augroup(group)
	end
	if once ~= nil then
		cmd.once = once
	end
	vim.api.nvim_create_autocmd(events, cmd)
end

--> Load main config
for _, source in ipairs({ "bootstrap", "opts", "keymaps", "autocmd" }) do
	local config = _require(
		"NeutronVim.core." .. source,
		"Couldn't source module \"NeutronVim.core."
			.. source
			.. '", located at:\n\n'
			.. (tostring(vim.fn.stdpath("config")):gsub("^/[^/]+/[^/]+", "~"))
			.. "/lua/NeutronVim/core/"
			.. source
			.. ".lua"
	)
	if config ~= true then
		local filepath = vim.fn.stdpath("config") .. "/lua/NeutronVim/core/" .. source .. ".lua"
		local trimmed = tostring(filepath):gsub("^/[^/]+/[^/]+", "~")
		local message

		if not (vim.loop or vim.uv).fs_stat(filepath) then
			message = "File not found:\n" .. trimmed
		elseif
			config:match("unexpected symbol")
			or config:match("syntax error")
			or config:match("expected .* close .* line .* near")
		then
			message = "Syntax error in file:\n" .. trimmed .. "\n\n" .. config
		elseif config:match("module '.*' not found") then
			message = "Required module missing in:\n" .. trimmed .. "\n\n" .. config
		elseif config:match("a nil value") then
			message = "Runtime error: Nil value in:\n" .. trimmed .. "\n\n" .. config
		elseif config:match("stack overflow") then
			message = "Stack overflow detected in:\n" .. trimmed .. "\n\n" .. config
		elseif config:match("attempt to perform arithmetic on a string value") then
			message = "Performing arithmetic on string value in in:\n" .. trimmed .. "\n\n" .. config
		elseif config:match("bad argument .* to") then
			message = "Invalid arguments in:\n" .. trimmed .. "\n\n" .. config
		elseif config:match("'<name>' expected near") then
			message = "Syntax error: Missing function name in:\n" .. trimmed .. "\n\n" .. config
		else
			message = "Unknown error in:\n" .. trimmed .. "\n\n" .. config
		end

		vim.defer_fn(function()
			vim.notify(" " .. message, vim.log.levels.ERROR, { title = "Module not imported error" })
		end, 500)
		vim.fn.setreg("a", vim.fn.stdpath("config") .. "/lua/NeutronVim/core/" .. source .. ".lua")
		vim.defer_fn(function()
			vim.notify(
				"Copied file location to `a` register,\npress <Ctrl-f> to open",
				vim.log.levels.INFO,
				{ title = "File Name Copied" }
			)
		end, 1000)
	end
end

--> Load custom sourceable config
_require("NeutronVim.core.custom", 'Custom configuration error in module "NeutronVim.core.custom"')
