-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
-- lspconfig for languages server protocols
-- see: https://github.com/neovim/nvim-lspconfig 
-- see: https://microsoft.github.io/language-server-protocol/implementors/servers/

local lspconfig = require "lspconfig"
local util = require("lspconfig/util")
local configs = require("lspconfig/configs")

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

-- TODO: configure eslint and prettier
-- Formatters (efm-langserver) {{{ 

local prettier = require "efm/prettier"
-- local luafmt = require "efm/luafmt"

local efm_languages = {
    lua = {luafmt},
    typescript = {prettier},
    javascript = {prettier},
    typescriptreact = {prettier},
    javascriptreact = {prettier},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    scss = {prettier},
    css = {prettier},
    markdown = {prettier},
    rust = {rustfmt},
}

lspconfig.efm.setup {
    cmd = {"efm-langserver"},
    root_dir = lspconfig.util.root_pattern(".git"),
    filetypes = vim.tbl_keys(efm_languages),
    init_options = {documentFormatting = true, codeAction = true},
    settings = {languages = efm_languages},
}

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

-- {{{ TailwindCSS language server
-- TODO: configure tailwindls
-- }}}

-- {{{ TSServer
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
    cmd = {"typescript-language-server", "--stdio" }

}
-- }}}

-- {{{ svelte-language-server
lspconfig.svelte.setup{
    cmd = {"/Users/development/.asdf/installs/nodejs/14.15.4/.npm/bin/svelteserver", "--stdio"}
}

-- }}}

-- {{{ diagnostic-languageserver
-- see: https://github.com/iamcco/diagnostic-languageserver
-- taken from: https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
-- local format_async = function(err, _, result, _, bufnr)
--     if err ~= nil or result == nil then return end
--     if not vim.api.nvim_buf_get_option(bufnr, "modified") then
--         local view = vim.fn.winsaveview()
--         vim.lsp.util.apply_text_edits(result, bufnr)
--         vim.fn.winrestview(view)
--         if bufnr == vim.api.nvim_get_current_buf() then
--             vim.api.nvim_command("noautocmd :update")
--         end
--     end
-- end
-- 
-- vim.lsp.handlers["textDocument/formatting"] = format_async
-- 
-- _G.lsp_organize_imports = function()
--     local params = {
--         command = "_typescript.organizeImports",
--         arguments = {vim.api.nvim_buf_get_name(0)},
--         title = ""
--     }
--     vim.lsp.buf.execute_command(params)
-- end
-- 
-- local on_attach = function(client, bufnr)
--     local buf_map = vim.api.nvim_buf_set_keymap
--     vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
--     vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
--     vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
--     vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
--     vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
--     vim.cmd("command! LspOrganize lua lsp_organize_imports()")
--     vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
--     vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
--     vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
--     vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
--     vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
--     vim.cmd(
--         "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
--     vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
-- 
-- buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
--     buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
--     buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
--     buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
--     buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
--     buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
--     buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
--     buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
--     buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
--     buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
--     buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
--               {silent = true})if client.resolved_capabilities.document_formatting then
--         vim.api.nvim_exec([[
--          augroup LspAutocommands
--              autocmd! * <buffer>
--              autocmd BufWritePost <buffer> LspFormatting
--          augroup END
--          ]], true)
--     end
-- end
-- 
-- local filetypes = {
--     typescript = "eslint",
--     typescriptreact = "eslint",
--     javascript = "eslint", 
--     svelte = "prettier",
--     html = "prettier",
-- }
-- 
-- local linters = {
--     eslint = {
--         sourceName = "eslint",
--         command = "yarn eslint",
--         rootPatterns = {".eslintrc.js", "package.json"},
--         debounce = 100,
--         args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
--         parseJson = {
--             errorsRoot = "[0].messages",
--             line = "line",
--             column = "column",
--             endLine = "endLine",
--             endColumn = "endColumn",
--             message = "${message} [${ruleId}]",
--             security = "severity"
--         },
--         securities = {[2] = "error", [1] = "warning"}
--     }
-- }
-- 
-- local formatters = {
--     prettier = {
--         command = "yarn prettier",
--         args = {"--stdin-filepath", "%filepath"},
--         rootPatterns = {".prettierrc", ".prettierrc.json", ".prettierignore"},
--     }
-- }
-- 
-- local formatFiletypes = {
--     typescript = "prettier",
--     typescriptreact = "prettier",
--     javascript = "prettier",
--     svelte = "prettier",
--     html = "prettier",
-- }
-- 
-- lspconfig.diagnosticls.setup {
--     on_attach = on_attach,
--     filetypes = vim.tbl_keys(filetypes),
--     init_options = {
--         filetypes = filetypes,
--         linters = linters,
--         formatters = formatters,
--         formatFiletypes = formatFiletypes
--     }
-- }
-- }}}

-- {{{ Python language servers

-- Microsoft Pyright
lspconfig.pyright.setup {
    cmd = {"/Users/development/.asdf/installs/nodejs/14.15.4/.npm/bin/pyright-langserver", "--stdio"},
}

-- jedi_language_server
-- see: https://github.com/pappasam/jedi-language-server 
-- lspconfig.jedi_language_server.setup{
--    cmd = {"/Users/development/.config/nvim/language-servers/jedi-language-server/venv/bin/jedi-language-server"},
-- }

-- palantir/pyls - python-language-server
-- seems to be the worst of the three
-- lspconfig.pyls.setup{
--    cmd = {"/Users/development/.config/nvim/language-servers/python-language-server/venv/bin/pyls"},
-- }

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

