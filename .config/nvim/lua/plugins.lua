-- This file is loaded by calling `lua require('packer')` from init.vim

require("packer").startup(
    function()
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        -- themes
        use "folke/tokyonight.nvim"

        -- gitsigns
        use {
            "lewis6991/gitsigns.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = function()
                require("gitsigns").setup{
                    yadm = {
                        enable = true
                    }
                }
            end
        }

        use "justinmk/vim-sneak"

        use {
            "akinsho/nvim-bufferline.lua",
            requires = {'kyazdani42/nvim-web-devicons'},
            config = function()
                require('bufferline').setup{}
            end
        }

        use {
            'hoob3rt/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            config = function()
                require('lualine').setup{
                    options = {
                        theme = 'tokyonight'
                    }
                }
            end
        }

        -- use 'lukas-reineke/indent-blankline.nvim' with lua branch
        -- taken from 'lukas-reineke' dotfiles
        use {
            "lukas-reineke/indent-blankline.nvim",
            branch = "lua",
            config = function()
                vim.g.indent_blankline_char = "│"
                vim.g.indent_blankline_filetype_exclude = {
                    "help",
                    "defx",
                    "vimwiki",
                    "man",
                    "gitmessengerpopup",
                    "diagnosticpopup"
                }
                vim.g.indent_blankline_buftype_exclude = {"terminal"}
                vim.g.indent_blankline_space_char_blankline = " "
                vim.g.indent_blankline_strict_tabs = true
                vim.g.indent_blankline_debug = true
                vim.g.indent_blankline_show_current_context = true
                vim.g.indent_blankline_context_patterns = {
                    "class",
                    "function",
                    "method",
                    "^if",
                    "while",
                    "for",
                    "with",
                   "func_literal",
                    "block",
                    "try",
                    "except",
                    "argument_list",
                    "object",
                    "dictionary"
                }
            end
        }
 

        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }

        -- nvim-lspconfig
        -- lsp configuration under `.lsp/` directory
        use 'neovim/nvim-lspconfig'

        use {
            "folke/lsp-trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {
                    -- defaults (https://github.com/folke/lsp-trouble.nvim#setup):
                    height = 10, -- height of the trouble list
                    icons = true, -- use dev-icons for filenames
                    mode = "workspace", -- "workspace" or "document"
                    fold_open = "", -- icon used for open folds
                    fold_closed = "", -- icon used for closed folds
                    action_keys = { -- key mappings for actions in the trouble list
                        close = "q", -- close the list
                        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                        refresh = "r", -- manually refresh
                        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
                        toggle_mode = "m", -- toggle between "workspace" and "document" mode
                        toggle_preview = "P", -- toggle auto_preview
                        preview = "p", -- preview the diagnostic location
                        close_folds = {"zM", "zm"}, -- close all folds
                        open_folds = {"zR", "zr"}, -- open all folds
                        toggle_fold = {"zA", "za"}, -- toggle fold of current file
                        previous = "k", -- preview item
                        next = "j" -- next item
                    },
                    indent_lines = true, -- add an indent guide below the fold icons
                    auto_open = false, -- automatically open the list when you have diagnostics
                    auto_close = false, -- automatically close the list when you have no diagnostics
                    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back
                    auto_fold = false, -- automatically fold a file trouble list at creation
                    signs = {
                        -- icons / text used for a diagnostic
                        error = "",
                        warning = "",
                        hint = "",
                        information = ""
                    },
                    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
                }
            end
        }

        -- nvim-treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require'nvim-treesitter.configs'.setup {
                    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                    highlight = {
                        enable = true, -- false will disable the whole extension
                    },
                }
            end
        }

        use "nvim-treesitter/playground"

        -- nvim-tree.lua
        use {
            'kyazdani42/nvim-tree.lua',
            requires = "kyazdani42/nvim-web-devicons",
        }

        -- Using nvim-tree.lua instead of NERDTree
        -- NERDTree
        -- use {
        --     'scrooloose/nerdtree',
        --     requires = {'ryanoasis/vim-devicons'},
        -- }

        use {
            'hrsh7th/nvim-compe',
            config = function()
              require"compe".setup {
                preselect = "always",
                source = {
                    path = true,
                    buffer = true,
                    vsnip = true,
                    nvim_lsp = true,
                    nvim_lua = true
                }
            }
            end
        }

        -- sniprun
        -- Run lines/blocks of code
        -- independently of the rest of the file
        -- supporting multiples languages
        -- Mac users NEED the Rust toolchain
        use {
            'michaelb/sniprun',
            run = 'bash ./install.sh',
            config = function()
                require'sniprun'.initial_setup()
            end
        }

        -- nvim-dap
        use {
            'mfussenegger/nvim-dap',
        }

        -- nvim-dap-python
        use {
            'mfussenegger/nvim-dap-python',
        }
        -- }}}

        -- vimscrip plugins
        -- Black python formater
        -- vimscrypt syntax config
        -- use 'psf/black'
        --  psf-black python formater
        --  See: https://github.com/psf/black/blob/master/docs/editor_integration.md
        --  neovim needs provier-python enabled
        --  See: https://github.com/psf/black/issues/1149
        --  Due to often usage of per-project virtualenvs
        --  a virtualenv for Neovim must be hard-coded
        --  via g:python3_host_prog
        --  See: nvim :help provider-python
        -- 
        --  Run black on save:
        --  autocmd BufWritePre *.py execute ':Black'

        -- ultisnips - vim snippet engine
        -- track the engine
        use 'SirVer/ultisnips'
        -- snippets are separeted from the engine:
        -- vim-snippets
        use 'honza/vim-snippets'

    end
)
