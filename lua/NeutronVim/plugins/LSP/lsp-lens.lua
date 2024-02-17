return {
  "VidocqH/lsp-lens.nvim",
  lazy = true,
  event = "LspAttach",
  config = function()
    local SymbolKind = vim.lsp.protocol.SymbolKind
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end
    local lens_status_ok, lens = pcall(require, "lsp-lens")
    if not lens_status_ok then
      print("lsp-lens not found!")
    end
    lens.setup({
      enable = true,
      include_declaration = true,
      sections = {
        definition = function(count)
          return icons.kind.Declaration .. "Definitions: " .. count
        end,
        references = function(count)
          return "  References: " .. count
        end,
        implements = function(count)
          return icons.kind.Interface .. "Implements: " .. count
        end,
        git_authors = function(latest_author, count)
          return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
        end,
      },
      target_symbol_kinds = {
        SymbolKind.Function,
        SymbolKind.Method,
        SymbolKind.Interface,
        SymbolKind.Property,
        SymbolKind.Variable,
      },
    })
  end,
}
