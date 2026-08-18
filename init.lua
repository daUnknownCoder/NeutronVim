if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
  vim.loader.enable()
end

local core = {
  "icons",
  "bootstrap",
  "options",
  "keymaps"
}

for _, source in ipairs(core) do
  local status_ok, fault = pcall(require, "NeutronVim.core." .. source)
  if not status_ok then
    vim.api.nvim_err_writeln("Error loading " .. source .. "\n\n" .. fault)
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    pcall(require, "NeutronVim.core.options")
    pcall(require, "NeutronVim.core.keymaps")
    pcall(vim.cmd.colorscheme, "tokyonight-night") 
  end,
})
