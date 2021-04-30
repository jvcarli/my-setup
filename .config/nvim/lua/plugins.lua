-- This file is loaded by calling `lua require('plugins')` from init.vim

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- themes
  use 'folke/tokyonight.nvim'

  -- gitsigns
  use {
  'lewis6991/gitsigns.nvim',
  requires = {'nvim-lua/plenary.nvim'},
  config = function()
    require('gitsigns').setup{
      yadm = {
        enable = true
      }
    }

  end
  }

  use 'justinmk/vim-sneak'

  use {
    'akinsho/nvim-bufferline.lua',
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

  -- indent blankline not working
  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- nvim-treesitter
  use 'neovim/nvim-lspconfig'
  -- configuration under `./local-lsp-configuration.lua`

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

end)
