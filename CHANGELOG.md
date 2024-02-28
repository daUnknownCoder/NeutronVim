# Changelog

## [5.4.0](https://github.com/daUnknownCoder/NeutronVim/compare/v5.3.0...v5.4.0) (2024-02-25)


### Features

* **Codesnap:** Add plugin to beautify snippets while sharing them. ([d83a50c](https://github.com/daUnknownCoder/NeutronVim/commit/d83a50c693268d27ddb4b852ac844666241ccc3f))


### Bug Fixes

* **hooks:** use hooks to set highlights when changing colorschemes ([0402846](https://github.com/daUnknownCoder/NeutronVim/commit/04028466068322c62fe925696e1ddaf4fa58d16e))
* **lazy.nvim:** Unnecessary double line virtual text ([c3b4cc6](https://github.com/daUnknownCoder/NeutronVim/commit/c3b4cc673f8ffeee2d7a9a6277ad91650db66e7f))
* **mini.animate:** black UI when new window are opened or closed ([2dbe712](https://github.com/daUnknownCoder/NeutronVim/commit/2dbe712a1797498bbf9149f472871b8857218f71))


### Performance Improvements

* **illuminate:** switch from `vim-illuminate` to `mini.cursorword` ([26dc99d](https://github.com/daUnknownCoder/NeutronVim/commit/26dc99d5864dc28351ddac149a584dd997759ab4))

## [5.3.0](https://github.com/daUnknownCoder/NeutronVim/compare/v5.2.1...v5.3.0) (2024-02-17)


### Features

* **lsp_attach:** Increase performance + lsp_attach check ([8e78a17](https://github.com/daUnknownCoder/NeutronVim/commit/8e78a17c76bc545928594d6cd1f9641390f46a2f))
* **tags completion:** &lt; and &gt; autocomplete ([928d358](https://github.com/daUnknownCoder/NeutronVim/commit/928d358d6830b7d68f761fea224af10ab559abbd))
* **tools:** better look, add few params ([436c042](https://github.com/daUnknownCoder/NeutronVim/commit/436c0423d572fe4bb2c360337fecfe40f49db15b))


### Bug Fixes

* **tab key:** updated rude behaviour of tab key while between words ([f2104e6](https://github.com/daUnknownCoder/NeutronVim/commit/f2104e6838539009290cfec5178234f4a585ce73))


### Performance Improvements

* **virtual_text:** virtual lines displayed on current line only ([b50125c](https://github.com/daUnknownCoder/NeutronVim/commit/b50125cddb56a1669020b218ee0099462cab68af))

## [5.2.1](https://github.com/daUnknownCoder/NeutronVim/compare/v5.2.0...v5.2.1) (2024-02-17)


### Performance Improvements

* **optimizations of events:** faster loading time, updated events ([9525944](https://github.com/daUnknownCoder/NeutronVim/commit/9525944ab2f7d8b68a2dc1fda2ce90f2a63ae7dd))

## [5.2.0](https://github.com/daUnknownCoder/NeutronVim/compare/v5.1.2...v5.2.0) (2024-02-06)


### Features

* **actions-preview.nvim:** switched from archived project to new one ([b85df2e](https://github.com/daUnknownCoder/NeutronVim/commit/b85df2ea0a489edf0510b2daac86cb519a7e35f4))

## [5.1.2](https://github.com/daUnknownCoder/NeutronVim/compare/v5.1.1...v5.1.2) (2024-02-02)


### Bug Fixes

* **<Tab>:** pressing &lt;Tab&gt; key doesn't freeze the terminal window ([302d824](https://github.com/daUnknownCoder/NeutronVim/commit/302d824b32169e680740193806a37691bb4078c7))

## [5.1.1](https://github.com/daUnknownCoder/NeutronVim/compare/v5.1.0...v5.1.1) (2024-01-26)


### Bug Fixes

* **codeium.vim:** codeium.vim is not working so downgraded ([1ca8674](https://github.com/daUnknownCoder/NeutronVim/commit/1ca8674b3cdc9991b56872888e594378b172d37f))

## [5.1.0](https://github.com/daUnknownCoder/NeutronVim/compare/v5.0.6...v5.1.0) (2024-01-24)


### Features

* **tab:** tab not working in between words (fixed) ([b05fccb](https://github.com/daUnknownCoder/NeutronVim/commit/b05fccb1c37fdfd3475ba9c8dda7ad92b894e23b))


### Bug Fixes

* **autocmd:** added a few autoclose on q windows ([c77ef73](https://github.com/daUnknownCoder/NeutronVim/commit/c77ef7378ec02c8dacc03636b747ced1aafcf5c3))

## [5.0.6](https://github.com/daUnknownCoder/NeutronVim/compare/v5.0.5...v5.0.6) (2024-01-24)


### Bug Fixes

* **alpha:** alpha changes coz some elements went out of screen ([1ac1726](https://github.com/daUnknownCoder/NeutronVim/commit/1ac17268fbb857b055ef015a7e72ccbe0d6e525f))

## [5.0.5](https://github.com/daUnknownCoder/NeutronVim/compare/v5.0.4...v5.0.5) (2024-01-13)


### Bug Fixes

* **lsp_lines:** lsp_lines update in insert not showing updates solved ([25a7e28](https://github.com/daUnknownCoder/NeutronVim/commit/25a7e289009893f6128fea830cf000223d4d520e))

## [5.0.4](https://github.com/daUnknownCoder/NeutronVim/compare/v5.0.3...v5.0.4) (2023-12-03)


### Bug Fixes

* **prettier:** changed prettier to prettierd for fastness ([27c9d98](https://github.com/daUnknownCoder/NeutronVim/commit/27c9d98bf3ffc444e907510f5221dea6b91f8f0a))

## [5.0.3](https://github.com/daUnknownCoder/NeutronVim/compare/v5.0.2...v5.0.3) (2023-12-02)


### Bug Fixes

* **none-ls:** python lsp ([dcca607](https://github.com/daUnknownCoder/NeutronVim/commit/dcca60763f34d581e1f32648f58052820b8d0013))

## [5.0.2](https://github.com/daUnknownCoder/NeutronVim/compare/v5.0.1...v5.0.2) (2023-11-06)


### Bug Fixes

* **cmp:** tab in free space writes tabout ([2a5893a](https://github.com/daUnknownCoder/NeutronVim/commit/2a5893aa57dc90a5a8395953352a8f045e5cfd48))

## [5.0.1](https://github.com/daUnknownCoder/NeutronVim/compare/v5.0.0...v5.0.1) (2023-11-03)


### Performance Improvements

* **colorscheme:** set to  to decrease startuptime ([64a3006](https://github.com/daUnknownCoder/NeutronVim/commit/64a30062f4fcdccdcc61e51fbd2fc85132a7fd97))

## [5.0.0](https://github.com/daUnknownCoder/NeutronVim/compare/v4.3.0...v5.0.0) (2023-10-31)


### ⚠ BREAKING CHANGES

* **none-ls:** Switched to none-ls [Linting & Formatting]

### Features

* **none-ls:** Switched to none-ls [Linting & Formatting] ([495c1aa](https://github.com/daUnknownCoder/NeutronVim/commit/495c1aa84d51db654811c527020757be0e58bb82))

## [4.3.0](https://github.com/daUnknownCoder/NeutronVim/compare/v4.2.0...v4.3.0) (2023-10-31)


### Features

* **none-ls:** Switched to none-ls [Linting & Formatting] ([6dc2f01](https://github.com/daUnknownCoder/NeutronVim/commit/6dc2f01428bae2e780e9df273ec510f3029bd63a))


### Bug Fixes

* **lazy:** removed redundant lazy specs ([9cc522d](https://github.com/daUnknownCoder/NeutronVim/commit/9cc522dccf3de18ba37c743e21a977ea05033a7f))
* **lsp-progress:** removed lsp-progress in lualine ([8ad286d](https://github.com/daUnknownCoder/NeutronVim/commit/8ad286ddbf4390e7c93343f93f13d631416b5dc4))

## [4.2.0](https://github.com/daUnknownCoder/NeutronVim/compare/v4.1.1...v4.2.0) (2023-10-31)


### Features

* **parinfer:** Added parinfer for editing lisp code ([fe6f437](https://github.com/daUnknownCoder/NeutronVim/commit/fe6f437843cd477145b6847ed1034ebd42489a15))
* **yuck:** Add yuck.vim for ft -&gt; yuck ([f50ca4d](https://github.com/daUnknownCoder/NeutronVim/commit/f50ca4d47c59232e44605b982ed322c878013b4e))

## [4.1.1](https://github.com/daUnknownCoder/NeutronVim/compare/v4.1.0...v4.1.1) (2023-10-30)


### Bug Fixes

* **lsp-lens:** removed pinning to commit as it is not required ([5aca1a7](https://github.com/daUnknownCoder/NeutronVim/commit/5aca1a70bafef34285fe2d93ec64c31225e27ecf))

## [4.1.0](https://github.com/daUnknownCoder/NeutronVim/compare/v4.0.0...v4.1.0) (2023-10-26)


### Features

* **tools:** added mbbill/UndoTree ([60e804d](https://github.com/daUnknownCoder/NeutronVim/commit/60e804da3ece8875806f7b56292cd4001d8cdaaf))


### Bug Fixes

* removed ambiguous usage of event for lualine ([4fc676e](https://github.com/daUnknownCoder/NeutronVim/commit/4fc676ed06a75c868b95a283159ad3f646ef9903))

## [4.0.0](https://github.com/daUnknownCoder/NeutronVim/compare/v3.0.1...v4.0.0) (2023-10-26)


### ⚠ BREAKING CHANGES

* **tools:** utils/ folder will now contain all utilities required for NeutronVim

### Features

* Better First startup screen showing lazy installations ([6396317](https://github.com/daUnknownCoder/NeutronVim/commit/639631790ccba78a9818fe79f1bbf79bf617800b))
* **healthchecks:** Better and more dependency checks ([d58447e](https://github.com/daUnknownCoder/NeutronVim/commit/d58447e44083d525fa57722941b314c67d6b75d4))
* **lsp-lens:** Added LSP Lens ([ce468da](https://github.com/daUnknownCoder/NeutronVim/commit/ce468da8dff0ecfb0c548469e6046a52850af428))
* **tools:** Added Utils/ folder for utils ([f859785](https://github.com/daUnknownCoder/NeutronVim/commit/f859785dfb8ad3f772295d1328169def662b31bf))


### Performance Improvements

* **vim.loader:** better loading of modules ([07b9fbb](https://github.com/daUnknownCoder/NeutronVim/commit/07b9fbbfdeea897abe8be27fd50c2e2962ef9eb9))

## [3.0.1](https://github.com/daUnknownCoder/NeutronVim/compare/v3.0.0...v3.0.1) (2023-10-24)


### Performance Improvements

* **disabled-built-ins:** more startup optimizations ([136891a](https://github.com/daUnknownCoder/NeutronVim/commit/136891a95d12c95f96b9fc4e51dec65080368b08))
* **rtp:** disable some rtp plugins for better perf ([9811780](https://github.com/daUnknownCoder/NeutronVim/commit/98117802625fbfc3a166c6e01fc29de5bf6e5287))

## [3.0.0](https://github.com/daUnknownCoder/NeutronVim/compare/v2.0.0...v3.0.0) (2023-10-24)


### ⚠ BREAKING CHANGES

* Startuptime performance optimized

### Features

* **lsp-timeout:** added lsp-timeout ([d1cb100](https://github.com/daUnknownCoder/NeutronVim/commit/d1cb100fe89e702f7872e97acdd8c7f5bf63830c))
* **nerdy:** add nerdy.nvim ([4b190aa](https://github.com/daUnknownCoder/NeutronVim/commit/4b190aaadcb9ce6a65784825e7a19a4e7655d58e))


### Bug Fixes

* load colorscheme b4 evrything else [forgot that earlier] ([4a0837c](https://github.com/daUnknownCoder/NeutronVim/commit/4a0837ca81d5581727f6493d60bb6321fd469d3f))
* **reconfigured:** made edits according to new lazy-loading of colors ([3db78b9](https://github.com/daUnknownCoder/NeutronVim/commit/3db78b994570a2b36eb7f470e8a7fbb4bb959cf1))


### Performance Improvements

* removed oil.nvim [too slow sometimes] ([6785629](https://github.com/daUnknownCoder/NeutronVim/commit/67856296bb75cb6ca144040de37271e7a33be4bf))
* Startuptime optimization ([8d411da](https://github.com/daUnknownCoder/NeutronVim/commit/8d411da4f917015dd2ef99a417f4b6e5437f0133))
* **UI:** lazy-loading of colorscheme and custom highlights ([8a49b79](https://github.com/daUnknownCoder/NeutronVim/commit/8a49b7994914a14a76d9bee650382974d18c6ff0))

## [2.0.0](https://github.com/daUnknownCoder/NeutronVim/compare/v1.3.1...v2.0.0) (2023-10-22)


### ⚠ BREAKING CHANGES

* Startuptime performance optimized

### Features

* added new snip loading ([0d8f540](https://github.com/daUnknownCoder/NeutronVim/commit/0d8f540f8d3850dd482c8745eb69ae4f5bf872dd))
* more snippets for luasnip [vscode] style ([02d2a02](https://github.com/daUnknownCoder/NeutronVim/commit/02d2a02fba9461a76c2a09e00e7a28b95e4053e7))


### Bug Fixes

* fixed conflicting ;k map ([7bdc419](https://github.com/daUnknownCoder/NeutronVim/commit/7bdc4198e006b63e03b7ba19d4c5f3646fb2d8ac))
* load colorscheme b4 evrything else [forgot that earlier] ([febd47b](https://github.com/daUnknownCoder/NeutronVim/commit/febd47bc3cc219c11b276b6372256114f679eedd))
* switched to mypy again ([1668016](https://github.com/daUnknownCoder/NeutronVim/commit/1668016634deba3fc048f6ce3d0818afe5422a1d))


### Performance Improvements

* Startuptime optimization ([6389464](https://github.com/daUnknownCoder/NeutronVim/commit/6389464db60f0304dcf86490a9db4a240c352cae))

## [1.3.1](https://github.com/daUnknownCoder/NeutronVim/compare/v1.3.0...v1.3.1) (2023-10-22)


### Bug Fixes

* added codeium cmp keymap ([8d5a9e6](https://github.com/daUnknownCoder/NeutronVim/commit/8d5a9e6aa8395d46ece5f6a26822c3c12debdaff))

## [1.3.0](https://github.com/daUnknownCoder/NeutronVim/compare/v1.2.0...v1.3.0) (2023-10-22)


### Features

* add and modified few icons ([bd5e39b](https://github.com/daUnknownCoder/NeutronVim/commit/bd5e39bc944cf96198ce42686ff1551d6c0c3bd5))
* **tools:** Add minimap.vim ([bb05bbb](https://github.com/daUnknownCoder/NeutronVim/commit/bb05bbbe367e7d8e372a1dab1f74b1a2b30732d6))
* **tools:** Add scrollbar ([5840572](https://github.com/daUnknownCoder/NeutronVim/commit/5840572d29cc88e5d6a9f923ac55bf0db81c7192))
* **tools:** add support for codeium ([a6bde55](https://github.com/daUnknownCoder/NeutronVim/commit/a6bde55c74e4958db1497cdb39c34d9fe253e4ca))


### Bug Fixes

* **tools:** removed bufferline ([92117f9](https://github.com/daUnknownCoder/NeutronVim/commit/92117f9d05fb091741daa43931c42988ef9e612e))

## [1.2.0](https://github.com/daUnknownCoder/NeutronVim/compare/v1.1.0...v1.2.0) (2023-10-21)


### Features

* added telescope-fzf-native ([2e86021](https://github.com/daUnknownCoder/NeutronVim/commit/2e86021c72ea655dcb2069e13b71e00516a9fe4d))


### Bug Fixes

* dont need  anymore ([a291e26](https://github.com/daUnknownCoder/NeutronVim/commit/a291e268a8736fc5d9a5af3d972566325d86bb30))
* fixed extra snips not loading in some scenarios ([e00ce5a](https://github.com/daUnknownCoder/NeutronVim/commit/e00ce5a3730b845d558dc80eea4331079c23060a))


### Performance Improvements

* better lazy-loading and whichkey loads after ui loading completes ([cd2a140](https://github.com/daUnknownCoder/NeutronVim/commit/cd2a1402cf09af942c8a4b190a0c828abf0c45dd))
* switched from  to ([06f7f0c](https://github.com/daUnknownCoder/NeutronVim/commit/06f7f0cf16dc2d41c34644461249c5e863f2e203))
* UI tweaks, disabled some rtp plugins for better perf ([1022ac5](https://github.com/daUnknownCoder/NeutronVim/commit/1022ac5ef1a81988b1e61ebc24ec0c1753a65a17))

## [1.1.0](https://github.com/daUnknownCoder/NeutronVim/compare/v1.0.0...v1.1.0) (2023-10-20)


### Features

* added logging for all OS ([4097ead](https://github.com/daUnknownCoder/NeutronVim/commit/4097ead4c064bcc33027465527c122355ab035a8))
* updated opts for lsp_signature ([2dc470b](https://github.com/daUnknownCoder/NeutronVim/commit/2dc470b4340682d6ed5af0207995b1e942533399))

## [1.0.0](https://github.com/daUnknownCoder/NeutronVim/compare/v0.2.0...v1.0.0) (2023-10-20)


### ⚠ BREAKING CHANGES

* Added akinsho/bufferline.nvim

### Features

* add nvim-spectre, removed moved plugins ([85b3b9f](https://github.com/daUnknownCoder/NeutronVim/commit/85b3b9ffdea2f5c2f230fdeb4795ba315e733231))
* Added Bufferline to NeutronVim ([d7355ca](https://github.com/daUnknownCoder/NeutronVim/commit/d7355ca0edccc7430421a7218a572cb7d135ee5a))
* added formatter and slow formatter functions ([f0aef06](https://github.com/daUnknownCoder/NeutronVim/commit/f0aef06f2724b8bdbd1d2a6aaf67e7ae8b46d099))
* added health.lua ([396a152](https://github.com/daUnknownCoder/NeutronVim/commit/396a15275b28f5f8d9377fb9a62d5164e5326691))
* added marksman lsp ([f55ae1b](https://github.com/daUnknownCoder/NeutronVim/commit/f55ae1b8b1ed19de02af8cbd42fa13b2fb100021))
* added marksman lsp for markdown editing ([9928cef](https://github.com/daUnknownCoder/NeutronVim/commit/9928cefc51322074ba9612d666a1272e4e954e50))
* Added snippets for [global, git, lua, md] ([8c20755](https://github.com/daUnknownCoder/NeutronVim/commit/8c20755ba927021def822a6eb028003da11c8ef8))


### Bug Fixes

* added stylua ignore ([ee8d4a9](https://github.com/daUnknownCoder/NeutronVim/commit/ee8d4a9d04a5263d49f8337d252a8554aa6d4611))
* changed keymap for moving lines up and down in insert mode ([00f98c1](https://github.com/daUnknownCoder/NeutronVim/commit/00f98c1ba16e45ac82b0f899103e60b3099ee610))
* **tools:** Removed diagflow.nvim ([8ae6313](https://github.com/daUnknownCoder/NeutronVim/commit/8ae63138183e601637ddc1c513efdfb39dc3bb03))


### Performance Improvements

* disabled ([865f021](https://github.com/daUnknownCoder/NeutronVim/commit/865f0215adff4ad6e66323f63bd79dacad2f7bab))

## [0.2.0](https://github.com/daUnknownCoder/NeutronVim/compare/v0.1.1...v0.2.0) (2023-10-19)


### Features

* **tools:** added neogit ([eda14ea](https://github.com/daUnknownCoder/NeutronVim/commit/eda14ea20bd742bf1a5350def81a8cd8847d5d41))


### Bug Fixes

* autorelease workflows ([49c390c](https://github.com/daUnknownCoder/NeutronVim/commit/49c390c3ccf1edc6bbdd058dc8b95cd7a7dd40f7))
* autorelease workflows ([0fc6fcf](https://github.com/daUnknownCoder/NeutronVim/commit/0fc6fcf72375b66cbe2589a7b3830018d6343158))
* autorelease workflows ([d3239c5](https://github.com/daUnknownCoder/NeutronVim/commit/d3239c56305338dd80ea3bbfe3d394c1490d2a37))
* autorelease workflows ([e88741d](https://github.com/daUnknownCoder/NeutronVim/commit/e88741d38a6417c42175e037bf7b9bea98c0b4e5))
* **diagflow:** some lsp do not support ```diagnostic.code``` ([e83365c](https://github.com/daUnknownCoder/NeutronVim/commit/e83365ca32d0edf816df0c721d4c8d7bee2b7709))
* **lint:** switched linter from mypy to flake8 ([396b839](https://github.com/daUnknownCoder/NeutronVim/commit/396b8396913e0fe099cf570853068833355ead61))
* **markdown-preview:** temporary fix for markdown-preview status failed bug ([21b026e](https://github.com/daUnknownCoder/NeutronVim/commit/21b026e99f5d7020db9c07099ad278c942d84f81))
* removed tests as it is not needed [for now] ([6ee47e3](https://github.com/daUnknownCoder/NeutronVim/commit/6ee47e3d1a4e5bc39ce3982c9912a24d9461149e))
* some merge errors ([01c3530](https://github.com/daUnknownCoder/NeutronVim/commit/01c353031ad5ce5b7c8e0bc9d1cb67d1c6a4bcfc))
* updated build instructions for markdown-preview.nvim ([b3e653d](https://github.com/daUnknownCoder/NeutronVim/commit/b3e653d2dac45ac515b66cd618580a10f483e12d))
* workflow autorelease ([bdf36d1](https://github.com/daUnknownCoder/NeutronVim/commit/bdf36d10797f67e08a52f1a6784c5f0c1be1bd92))
