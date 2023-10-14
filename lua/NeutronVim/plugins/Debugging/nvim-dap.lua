return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "mfussenegger/nvim-dap-python",
      ft = { "python" },
    },
    "rcarriga/nvim-dap-ui",
  },
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    local dap_py_status_ok, dap_py = pcall(require, "dap-python")
    if not dap_py_status_ok then
      print("dap-python not found!")
    end
    local dap_status_ok, dap = pcall(require, "dap")
    if not dap_status_ok then
      print("nvim-dap not found!")
    end
    local dapui_status_ok, dapui = pcall(require, "dapui")
    if not dapui_status_ok then
      print("nvim-dapui not found!")
    end

    dap_py.setup(path)
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
      dap_py.test_method()
    end)
  end,
}
