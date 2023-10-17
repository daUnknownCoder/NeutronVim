return {
  "dgagn/diagflow.nvim",
  lazy = true,
  event = "LspAttach",
  config = function()
    local diagflow_status_ok, diagflow = pcall(require, "diagflow")
    if not diagflow_status_ok then
      print("diagflow not found!")
    end
    diagflow.setup({
      enable = function()
        return vim.bo.filetype ~= "lazy"
      end,
      format = function(diagnostics)
        return "[Diagnostics] "
          .. diagnostics.message
          .. " By: "
          .. diagnostics.source
          .. " Type: "
          .. diagnostics.code
          .. "."
      end,
      scope = "line",
      show_sign = true,
      padding_right = 0,
      update_event = { "DiagnosticChanged", "BufReadPost", "InsertEnter" },
    })
  end,
}
