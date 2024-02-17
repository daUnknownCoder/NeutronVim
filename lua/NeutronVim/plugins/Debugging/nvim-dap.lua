return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "mfussenegger/nvim-dap-python",
      ft = { "python" },
    },
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jbyuki/one-small-step-for-vimkind",
  },
  lazy = true,
  keys = {
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint [DAP] " },
    {
      "<leader>dp",
      function()
        require("dap-python").test_method()
      end,
      desc = "Run test method [DAP] ",
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle({})
      end,
      desc = "Dap UI [DAP] ",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      desc = "Evaluate current expression [DAP] ",
      mode = { "n", "v" },
    },
  },
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
    local dap_virtual_text_status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
    if not dap_virtual_text_status_ok then
      print("nvim-dap-virtual-text not found!")
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
    dap_virtual_text.setup({
      enabled = true,
      highlight_new_as_changed = true,
      virt_text_pos = "eol",
      all_frames = true,
    })
  end,
}
