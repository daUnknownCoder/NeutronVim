<h1 align="center">Welcome to NeutronVim 👋</h1>

![Snake](https://github.com/daUnknownCoder/NeutronVim/blob/output/github-contribution-grid-snake-dark.svg)

<div align="center"><p>
    <a href="https://github.com/daUnknownCoder/NeutronVim/releases/tag/release">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/daUnknownCoder/NeutronVim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/daUnknownCoder/NeutronVim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/daUnknownCoder/NeutronVim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/daUnknownCoder/NeutronVim/blob/nvim/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/daUnknownCoder/NeutronVim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/daUnknownCoder/NeutronVim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/daUnknownCoder/NeutronVim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/daUnknownCoder/NeutronVim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/daUnknownCoder/NeutronVim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/daUnknownCoder/NeutronVim">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/daUnknownCoder/NeutronVim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>

### 🏠 [Homepage](https://github.com/daUnknownCoder/NeutronVim)

## Install

```sh
git clone https://github.com/daUnknownCoder/Neutronvim ~/.config/nvim
```

## Author

👤 **daUnknownCoder**

- Website: https://github.com/daUnknownCoder
- Github: [@daUnknownCoder](https://github.com/daUnknownCoder)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](https://github.com/daUnknownCoder/NeutronVim/issues).

## Show your support

Give a ⭐️ if this project helped you!

</p>

## Current File Tree [For Better Debugging]

- 📂 **nvim**
  - 📄 [CHANGELOG.md](CHANGELOG.md)
  - 📄 [LICENCE](LICENCE)
  - 📄 [README.md](README.md)
  - 📂 **doc**
    - 📄 [NeutronVim.txt](doc/NeutronVim.txt)
  - 📄 [init.lua](init.lua)
  - 📄 [lazy\-lock.json](lazy-lock.json)
  - 📄 [list.md](list.md)
  - 📂 **lua**
    - 📂 **NeutronVim**
      - 📂 **core**
        - 📄 [autocmd.lua](lua/NeutronVim/core/autocmd.lua)
        - 📄 [icons.lua](lua/NeutronVim/core/icons.lua)
        - 📄 [opts.lua](lua/NeutronVim/core/opts.lua)
        - 📄 [remaps.lua](lua/NeutronVim/core/remaps.lua)
      - 📄 [lazy.lua](lua/NeutronVim/lazy.lua)
      - 📂 **plugins**
        - 📂 **Autocompletion**
          - 📄 [cmp.lua](lua/NeutronVim/plugins/Autocompletion/cmp.lua)
        - 📂 **Debugging**
          - 📄 [nvim\-dap.lua](lua/NeutronVim/plugins/Debugging/nvim-dap.lua)
        - 📂 **File\-Management**
          - 📄 [harpoon.lua](lua/NeutronVim/plugins/File-Management/harpoon.lua)
          - 📄 [nvim\-tree.lua](lua/NeutronVim/plugins/File-Management/nvim-tree.lua)
          - 📄 [oil.lua](lua/NeutronVim/plugins/File-Management/oil.lua)
          - 📄 [telescope.lua](lua/NeutronVim/plugins/File-Management/telescope.lua)
        - 📂 **Formatting**
          - 📄 [formatting.lua](lua/NeutronVim/plugins/Formatting/formatting.lua)
        - 📂 **Git\-Integration**
          - 📄 [git.lua](lua/NeutronVim/plugins/Git-Integration/git.lua)
        - 📂 **LSP**
          - 📄 [codeaction.lua](lua/NeutronVim/plugins/LSP/codeaction.lua)
          - 📄 [diagflow.lua](lua/NeutronVim/plugins/LSP/diagflow.lua)
          - 📄 [fidget.lua](lua/NeutronVim/plugins/LSP/fidget.lua)
          - 📄 [hover.lua](lua/NeutronVim/plugins/LSP/hover.lua)
          - 📄 [lsp_lines.lua](lua/NeutronVim/plugins/LSP/lsp_lines.lua)
          - 📄 [lspconfig.lua](lua/NeutronVim/plugins/LSP/lspconfig.lua)
          - 📄 [lspsaga.lua](lua/NeutronVim/plugins/LSP/lspsaga.lua)
          - 📄 [mason.lua](lua/NeutronVim/plugins/LSP/mason.lua)
          - 📄 [renamer.lua](lua/NeutronVim/plugins/LSP/renamer.lua)
        - 📂 **Linting**
          - 📄 [linting.lua](lua/NeutronVim/plugins/Linting/linting.lua)
        - 📂 **UI**
          - 📄 [alpha.lua](lua/NeutronVim/plugins/UI/alpha.lua)
          - 📄 [barbecue.lua](lua/NeutronVim/plugins/UI/barbecue.lua)
          - 📄 [colorscheme.lua](lua/NeutronVim/plugins/UI/colorscheme.lua)
          - 📄 [foldings.lua](lua/NeutronVim/plugins/UI/foldings.lua)
          - 📄 [lualine.lua](lua/NeutronVim/plugins/UI/lualine.lua)
          - 📄 [noice.lua](lua/NeutronVim/plugins/UI/noice.lua)
          - 📄 [notify.lua](lua/NeutronVim/plugins/UI/notify.lua)
        - 📂 **Utils**
          - 📄 [flash.lua](lua/NeutronVim/plugins/Utils/flash.lua)
          - 📄 [indents_delims.lua](lua/NeutronVim/plugins/Utils/indents_delims.lua)
          - 📄 [miscellaneous.lua](lua/NeutronVim/plugins/Utils/miscellaneous.lua)
          - 📄 [toggleterm.lua](lua/NeutronVim/plugins/Utils/toggleterm.lua)
          - 📄 [treesitter.lua](lua/NeutronVim/plugins/Utils/treesitter.lua)
          - 📄 [which\-key.lua](lua/NeutronVim/plugins/Utils/which-key.lua)

---
