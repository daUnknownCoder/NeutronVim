local M = {}

local start = vim.health.start
local info = vim.health.info
local ok = vim.health.ok
local warn = vim.health.warn
local error = vim.health.error

local git = { url = "https://github.com/" }

function git.available()
	return vim.fn.executable("git") == 1
end

function git.version()
	local output = vim.api.nvim_exec("!git --version", true):match("%d+%.%d+%.%d+")

	if output then
		local version_str = output:match("%d+%.%d+%.%d+")
		if version_str then
			local parts = vim.split(version_str, "%.")
			local major = tonumber(parts[1])
			local minor = tonumber(parts[2])
			local patch = tonumber(parts[3])
			return { major = major, minor = minor, patch = patch, str = version_str }
		end
	end
	return nil
end

function M.check()
	start("Starting check")

	info(
		"NeutronVim Version: "
			.. vim.json.decode(
				table.concat(vim.fn.readfile(vim.fn.stdpath("config") .. "/.release-please-manifest.json"), "\n")
			)["."]
	)
	info("Neovim Version: v" .. vim.fn.matchstr(vim.fn.execute("version"), "NVIM v\\zs[^\n]*"))

	if vim.version().prerelease then
		warn("Neovim nightly is not officially supported and may have breaking changes")
	elseif vim.fn.has("nvim-0.10") == 1 then
		ok("Using stable Neovim >= 0.10.0")
	elseif vim.fn.has("nvim-0.9.5") == 1 then
		info("Using old Neovim >= 0.9.5, We may drop support for this in the future")
	else
		error("Neovim >= 0.9.0 is required")
	end

	local programs = {
		{
			cmd = { "git" },
			type = "error",
			msg = "Git is required for core functionality of NeutronVim.",
			extra_check = function(program)
				local git_version = git.git_version()
				if git_version then
					if git_version.major < 2 or (git_version.major == 2 and git_version.minor < 19) then
						program.msg = ("Git %s installed, >= 2.19.0 is required"):format(git_version.str)
					else
						return true
					end
				else
					program.msg = "Unable to validate git version"
				end
			end,
		},
		-- {
		-- 	cmd = { "markmap" },
		-- 	type = "warn",
		-- 	msg = "Used for markmap plugin.",
		-- },
		-- { cmd = { "lazygit" }, type = "warn", msg = "Used for LazyGit plugin." },
		-- { cmd = { "rg" }, type = "error", msg = "Used by nvim-cmp and telescope for regex search." },
		-- { cmd = { "fd" }, type = "error", msg = "Used by telescope for file search." },
		-- { cmd = { "yazi" }, type = "info", msg = "Used for yazi plugin." },
		-- { cmd = { "node" }, type = "error", msg = "Used for core functionality of NeutronVim." },
	}

	for _, program in ipairs(programs) do
		if type(program.cmd) == "string" then
			program.cmd = { program.cmd }
		end
		local name = table.concat(program.cmd, "/")
		local found = false
		for _, cmd in ipairs(program.cmd) do
			if vim.fn.executable(cmd) == 1 then
				name = cmd
				found = true
				break
			end
		end

		if found then
			ok(("`%s` is installed: %s"):format(name, program.msg))
		else
			(program.type == "error" and error or warn)(("`%s` is not installed: %s"):format(name, program.msg))
		end
	end
	info("")
	info("Write `:bw` to close `:checkhealth` gracefully.")
end

return M
