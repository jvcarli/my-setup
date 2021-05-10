-- This file is loaded by calling `lua require('packer')` from init.vim

require("packer").startup(function()
    --=======================================--
    --           Plugin management           --
    --=======================================--
    
    -- A use-package inspired plugin manager for Neovim.
    -- Packer plugin manager can manage itself
    use "wbthomason/packer.nvim" -- lua plugin

    --=======================================--
    --         Movement & edit plugins       --
    --=======================================--
    -- TODO: include movement and edit plugins
    
    --=======================================--
    --      IDE (completion, debugging)      --
    --=======================================--

    -- nvim-lspconfig
    -- lsp configuration under ./lsp directory
    use 'neovim/nvim-lspconfig' -- lua plugin

    use {
        "folke/lsp-trouble.nvim", -- lua plugin
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

    -- nvim-compe:
    -- Auto completion plugin for nvim LSP written in Lua.
    use {
        'hrsh7th/nvim-compe', -- lua plugin
        config = function()
            require'compe'.setup {
                enabled = true;
                autocomplete = true;
                debug = false;
                min_length = 1;
                preselect = 'enable';
                throttle_time = 80;
                source_timeout = 200;
                incomplete_delay = 400;
                max_abbr_width = 100;
                max_kind_width = 100;
                max_menu_width = 100;
                documentation = true;

                source = {
                    path = true;
                    buffer = true;
                    calc = true;
                    nvim_lsp = true;
                    nvim_lua = true;
                    vsnip = true;
                    ultisnips = true;
                };
            }
        end
    }

    -- nvim-lsp-ts-utils: 
    -- TSServer enhancer
    -- Utilities to improve the TypeScript development experience for Neovim's built-in LSP client.
    use "jose-elias-alvarez/nvim-lsp-ts-utils" -- lua plugin

    -- nvim-dap: debug adaptor protocol client implementation for Neovim
    use "mfussenegger/nvim-dap" -- lua plugin

    -- nvim-dap-python: python interface for dap
    -- nvim-dap extension, providing default configurations
    -- for python and methos to debug individual test methods
    -- or classes.
    use "mfussenegger/nvim-dap-python" -- lua plugin 

    -- emmet-vim: emmet completion in vim
    -- see: https://github.com/mattn/emmet-vim
    -- emmet plugin keymappings are stored in nvim/lua/mappings.lua
    use 'mattn/emmet-vim' -- vim script plugin

    --=======================================--
    --                UI plugins             --
    --=======================================--

    -- A dark and ligth Neovim theme ported from Visual Studio's TokyoNight theme
    -- see: https://github.com/folke/tokyonight.nvim
    -- config under ./themes directory
    use "folke/tokyonight.nvim" -- lua plugin

    -- nvim-bufferline: 
    -- buffer line with minimal tab integration
    -- inspired by emacs centaur tabs plugin
    use {
        "akinsho/nvim-bufferline.lua", -- lua plugin
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require('bufferline').setup{}
        end
    }

    -- gitsigns
    -- Git signs written in pure lua
    -- with yadm support
    use {
        "lewis6991/gitsigns.nvim", -- lua plugin
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
            require("gitsigns").setup{
                yadm = {
                    enable = true
                }
            }
        end
    }

    -- lualine.nvim
    -- TODO: look for how to config better and other alternatives to lualine
    -- A blazing fast and easy to configure 
    -- neovim statusline plugin written in pure lua.
    use {
        'hoob3rt/lualine.nvim', -- lua plugin
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'tokyonight'
                }
            }
        end
    }

    -- vim-hexokinase:
    -- asynchronously display the colours in the file 
    -- (#rrggbb, #rgb, rgb(a)? functions, hsl(a)? functions, web colours, custom patterns)
    use {
        'RRethy/vim-hexokinase', -- vim script plugin
        run = 'make hexokinase'
    }

    -- indent-blankline.nvim
    -- Indent guides for Neovim
    -- use 'lukas-reineke/indent-blankline.nvim' with lua branch
    -- config taken from 'lukas-reineke' dotfiles
    use {
        "lukas-reineke/indent-blankline.nvim", -- vim script plugin
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

    --=======================================--
    --             Syntax Plugins            --
    --=======================================--

    -- nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter', -- lua plugin
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                highlight = {
                    enable = true, -- false will disable the whole extension
                },
                -- nvim-ts-autotag config
                autotag = {
                    enable = true,
                }
            }
        end
    }

    -- nvim-treesitter/playground
    -- View treesitter information directly in Neovim
    use "nvim-treesitter/playground" -- lua plugin

    -- nvim-ts-autotag
    -- Use tresitter to autoclose and autorename html tags
    use "windwp/nvim-ts-autotag" -- lua plugin

    -- nvim-tree.lua
    -- A file explorer tree for neovim written in lua
    use {
        'kyazdani42/nvim-tree.lua', -- lua plugin
        requires = "kyazdani42/nvim-web-devicons",
    }

    --=======================================--
    --           Workflow Plugins            --
    --=======================================--
    
    -- vim sneak
    -- Jump to any location specified by two characters.
    -- TODO: learn how to use it and configure it
    use "justinmk/vim-sneak" -- vim script plugin

    -- telescope.nvim
    -- highly extendable fuzzy finder over lists.
    -- Built on the latest features from neovim core. 
    -- Centered around modularity, allowing for easy customization.
    use {
        'nvim-telescope/telescope.nvim', -- lua plugin
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- sniprun
    -- Run lines/blocks of code
    -- independently of the rest of the file
    -- supporting multiples languages
    -- Mac users NEED the Rust toolchain
    -- to build and install the plugin
    use {
        'michaelb/sniprun', -- lua plugin
        run = 'bash ./install.sh',
        config = function()
            require'sniprun'.initial_setup()
        end
    }

    -- ultisnips - vim snippet engine
    -- snippets are separeted from the engine:
    -- using: vim-snippets for snippets
    use 'SirVer/ultisnips' -- vim script plugin

    -- vim-snippets
    use 'honza/vim-snippets' -- vim script plugin

    -- CmdlineComplete: 
    -- COMMAND mode tab like completion from words in the current file
    -- See: https://github.com/vim-scripts/CmdlineComplete
    -- See: http://www.vim.org/scripts/script.php?script_id=2222
    use 'vim-scripts/CmdlineComplete' -- vim script plugin

    -- git-messenger
    -- reveal the commit messages under the cursor
    -- See: https://github.com/rhysd/git-messenger.vim
    use {
        "rhysd/git-messenger.vim", -- vim script plugin
        -- config = function()
        --     vim.g.git_messenger_floating_win_opts = {border = vim.g.floating_window_border_dark}
        -- end
    }

end)
