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
    "mxsdev/nvim-dap-vscode-js",
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
    dapui.setup({
      icons = { expanded = "", collapsed = "" },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.5 },
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 60,
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25,
          position = "bottom",
        },
      },
      floating = {
        border = vim.g.floating_window_border,
      },
    })
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "Function", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Comment", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "🠶", texthl = "String", linehl = "DiffAdd", numhl = "" })

    require("dap-vscode-js").setup({
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    })
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        host = "127.0.0.1",
        port = function()
          local co = coroutine.running()
          vim.ui.input({
            prompt = "Port: ",
            relative = "win",
          }, function(input)
            coroutine.resume(co, tonumber(input))
          end)

          return coroutine.yield()
        end,
      },
    }

    dap.adapters.nlua = function(callback, config)
      callback({ type = "server", host = config.host, port = config.port })
    end
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
