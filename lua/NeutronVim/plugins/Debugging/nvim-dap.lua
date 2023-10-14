return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "mfussenegger/nvim-dap-python",
      ft = { "python" },
    },
    {
      "rcarriga/nvim-dap-ui",
    },
  },
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path)
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    -- luacheck: ignore vim
    local keymap = vim.keymap.set
    keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")
    keymap("n", "<leader>dpr", function()
      require("dap-python").test_method()
    end)
  end,
}
