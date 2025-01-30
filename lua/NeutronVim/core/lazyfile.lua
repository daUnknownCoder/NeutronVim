local function lazyfile()
	_autocmd("BufReadPost", "*", function(event)
		if vim.v.vim_did_enter == 1 then
			return
		end

		local ft = vim.filetype.match({ buf = event.buf })
		if ft then
			local lang = vim.treesitter.language.get_lang(ft)
			if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
				vim.bo[event.buf].syntax = ft
			end

			vim.cmd([[redraw]])
		end
	end, _augroup("LazyFile"), true)

	local Event = require("lazy.core.handler.event")

	Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
	Event.mappings["User LazyFile"] = Event.mappings.LazyFile
end
lazyfile()
return lazyfile
