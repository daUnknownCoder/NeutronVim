return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = function()
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")

    return {
      preset = "helix",
      defaults = {},
      triggers = {
        { "<auto>", mode = "nxso" },
        { "f", mode = "n" },
        { "m", mode = "n" },
        { "\\", mode = "n" },
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>s", group = "Split Management" },
          { "<leader>t", group = "Tab Management" },
          { "<leader>y", group = "Yank" },
          { "<leader>m", group = "Miscellaneous" },
          { "s", group = "Search [Flash]" },
        },
        
        {
          mode = { "n" },
          { "f", group = icons.ui.Telescope .. "Telescope" },
          { "\\", group = icons.kind.Lsp .. "LSP" },
          { ";l", group = icons.git.Branch .. "Git" },
          
          { "<leader>u", group = "Foldings [UFO]" },
          { "<leader>w", group = "Window Management" },
          { "gc", group = "Comment linewise" },
          { "gb", group = "Comment blockwise" },
          { "gs", group = "Surround" },
        },
      },
    }
  end,
  keys = {
    { "<leader>", mode = { "n", "v" } },
    { "<c-w>", mode = { "n" } },
    { ";", mode = { "n" } },
    { "\\", mode = { "n" } },
    { "g", mode = { "n", "v" } },
    { "f", mode = { "n" } },
    { "s", mode = { "n", "v" } },
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
    {
      "<c-w><space>",
      function()
        require("which-key").show({ keys = "<c-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local wk = require("which-key")
    wk.setup(opts)
  end,
}
