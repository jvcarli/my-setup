-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
-- lspconfig for languages server protocols
-- see: https://github.com/neovim/nvim-lspconfig 
-- see: https://microsoft.github.io/language-server-protocol/implementors/servers/

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local configs = require("lspconfig/configs")
-- local M = {}

--  {{{ LSP Completion symbols
vim.lsp.protocol.CompletionItemKind = {
    " [text]",
    " [method]",
    " [function]",
    " [constructor]",
    "ﰠ [field]",
    " [variable]",
    " [class]",
    " [interface]",
    " [module]",
    " [property]",
    " [unit]",
    " [value]",
    " [enum]",
    " [key]",
    "﬌ [snippet]",
    " [color]",
    " [file]",
    " [reference]",
    " [folder]",
    " [enum member]",
    " [constant]",
    " [struct]",
    "⌘ [event]",
    " [operator]",
    "♛ [type]"
}
-- }}}

-- M.symbol_kind_icons = {
--     Function = "",
--     Method = "",
--     Variable = "",
--     Constant = "",
--     Interface = "",
--     Field = "ﰠ",
--     Property = "",
--     Struct = "",
--     Enum = "",
--     Class = ""
-- }

-- M.symbol_kind_colors = {
--     Function = "green",
--     Method = "green",
--     Variable = "blue",
--     Constant = "red",
--     Interface = "cyan",
--     Field = "blue",
--     Property = "blue",
--     Struct = "cyan",
--     Enum = "yellow",
--     Class = "red"
-- }

-- TODO: include explanation about on_attach function
local on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end
end

-- Formatters (efm-langserver) {{{ 
-- diagnostic-languageserver (deprecated in favor of efm-langserver)

local prettier = require "efm/prettier"
local black = require "efm/black"
local shellcheck = require "efm/shellcheck"
local eslint = require "efm/eslint"
-- local luafmt = require "efm/luafmt"

-- efm-langserver main setup
lspconfig.efm.setup{
    init_options = {documentFormatting = true},
    on_attach = on_attach,
    -- filetypes = {"python", "lua"},
    filetypes = {
        "python",
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
        "yaml",
        "json",
        "html",
        "scss",
        "css",
        "markdown",
        "sh",
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = {black},
            typescript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            javascript = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            yaml = {prettier},
            json = {prettier},
            html = {prettier},
            scss = {prettier},
            css = {prettier},
            markdown = {prettier},
            sh = {shellcheck}
        }
    }
}
-- lspconfig.efm.setup {
--     cmd = {"efm-langserver"},
--     root_dir = root_pattern(".git"),
--     filetypes = vim.tbl_keys(efm_languages),
--     init_options = {documentFormatting = true, codeAction = true},
--     settings = {languages = efm_languages},
-- }

-- local prettier = {
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"},
--   lintIgnoreExitCode = true,
--   formatCommand = "prettier",
--   formatStdin = true
-- }
-- 
-- lspconfig.tsserver.setup {
--   on_attach = function(client)
--     if client.config.flags then
--       client.config.flags.allow_incremental_sync = true
--     end
--     client.resolved_capabilities.document_formatting = false
--     set_lsp_config(client)
--   end
-- }
-- 
-- lspconfig.efm.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = true
--     client.resolved_capabilities.goto_definition = false
--     set_lsp_config(client)
--   end,
--   root_dir = function()
--     if not prettier_config_exists() then
--       return nil
--     end
--     return vim.fn.getcwd()
--   end,
--   settings = {
--     languages = {
--       javascript = {prettier},
--       javascriptreact = {prettier},
--       ["javascript.jsx"] = {prettier},
--       typescript = {prettier},
--       ["typescript.tsx"] = {prettier},
--       typescriptreact = {prettier}
--     }
--   },
--   filetypes = {
--     "html",
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescript.tsx",
--     "typescriptreact"
--   },
-- }
-- 
-- local function eslint_config_exists()
--   local prettierrc = vim.fn.glob(".prettierrc*", 0, 1)
-- 
--   if not vim.tbl_isempty(prettierrc) then
--     return true
--   end
-- 
--   if vim.fn.filereadable("package.json") then
--     if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
--       return true
--     end
--   end
-- 
--   return false
-- end

-- }}}

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin
lspconfig.html.setup {on_attach = on_attach}

-- {{{ TSServer - Typescript server
lspconfig.tsserver.setup {
    -- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
    -- Use globally installed typescript-language-server
    -- the FULL PATH CAN'T BE declared MANUALLY 
    -- because `asdf` will get confused  
    -- when there's a `.tool-versions` file in the working directory.
    --
    -- tsserver dependencies (nodejs): typescript and typescript-language-server
    -- install them GLOBALLY in EVERY asdf managed NodeJS with: 
    -- `npm install -g typescript typescript-language-server`
    -- the shim path is declared instead of just `typescript-language-server`
    -- becuase nvim lsp will produce errors if not
    -- cmd = {"/Users/development/.asdf/shims/typescript-language-server", "--stdio" }
    cmd = {"typescript-language-server", "--stdio" },
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false -- turns off tsserver document formatting in favor of efm-langserver
        require "nvim-lsp-ts-utils".setup {} -- use jose-elias-alvarez/nvim-lsp-ts-utils enhancer
    end

}
-- }}}

-- {{{ svelte-language-server
-- You MUST install svelteserver GLOBALLY in every asdf managed NodeJs with:
-- npm install -g svelte-language-server
lspconfig.svelte.setup{
    on_attach = on_attach,
    cmd = {"svelteserver", "--stdio"},
    filetypes = { "svelte" }
}

-- }}}

-- {{{ TailwindCSS language server
-- TODO: configure tailwindls
-- }}}

-- {{{ Bash language server
-- https://github.com/bash-lsp/bash-language-server
lspconfig.bashls.setup {on_attach = on_attach}
-- }}}

-- {{{ Python language servers

-- Microsoft Pyright
-- TODO: install pyright-langserver globally
-- and change `cmd` accordingly
lspconfig.pyright.setup {
    cmd = {"/Users/development/.asdf/installs/nodejs/14.15.4/.npm/bin/pyright-langserver", "--stdio"},
}

-- jedi_language_server
-- see: https://github.com/pappasam/jedi-language-server 
-- lspconfig.jedi_language_server.setup{
--    cmd = {"/Users/development/.config/nvim/language-servers/jedi-language-server/venv/bin/jedi-language-server"},
-- }

-- palantir/pyls - python-language-server
-- lspconfig.pyls.setup{
lspconfig.pyls.setup{
    -- see: https://www.reddit.com/r/neovim/comments/jhgkid/disable_pyls_linting_for_nvm_lsp/
    cmd = {"/Users/development/.config/nvim/language-servers/python-language-server/venv/bin/pyls"},
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false -- remove formatting capabilitis so it doesn't conficlit with efm/black 
    end,
    settings = {
        pyls = {
            plugins = {
                pycodestyle =  {
                    enabled = true,
                    ignore = {
                        "E501" -- E501 line too long error: removed in favor of python Black formatter
                    }
                },
                pydocstyle = {
                    enabled = true -- disabled by default
                },
                -- pylint =  {
                --     enabled = false,
                -- },
                autopep8 = {
                    enabled = false, -- disabled in favor of Black formatter
                },
                yapf = {
                    enabled = false, -- disabled in favor of Black formatter

                }
            }
        }
    }
}

-- }}}

-- {{{ gopls - Golang official language server
-- See: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-v050
lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
          staticcheck = true,
        },
    },
}
-- }}}

-- ????
-- return M
