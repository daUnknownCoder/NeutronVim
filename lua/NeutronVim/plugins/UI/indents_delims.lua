return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    lazy = true,
    dependencies = {
      { "HiPhish/rainbow-delimiters.nvim", event = "InsertEnter", lazy = true },
    },
    config = function()
      local indent_blankline_status_ok, indent_blankline = pcall(require, "ibl")
      if not indent_blankline_status_ok then
        print("indent_blankline not found!")
      end
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

      vim.g.rainbow_delimiters = { highlight = highlight }

      indent_blankline.setup({
        indent = {
          highlight = highlight,
          char = "│",
        },
        scope = {
          enabled = true,
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "BufReadPost",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
