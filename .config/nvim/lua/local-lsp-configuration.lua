-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- lspconfig for languages servers protocols
-- see: https://microsoft.github.io/language-server-protocol/implementors/servers/


local nvim_lsp = require("lspconfig")

-- TODO: configure eslint and prettier
-- See: https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c

-- {{{ TSServer
nvim_lsp.tsserver.setup {
    -- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
    -- Use globally installed typescript-language-server
    -- the FULL PATH MUST BE declared MANUALLY 
    -- because `asdf` use shims to change bin executables 
    -- if there's a `.tool-versions` file in the working directory.
    --
    -- tsserver dependencies (nodejs): typescript and typescript-language-server
    -- install them with: `npm install -g typescript typescript-language-server`
    cmd = {
        "/Users/development/.asdf/installs/nodejs/14.15.4/.npm/bin/typescript-language-server",
        "--stdio"
    },

}
-- }}}

-- {{{ Pyright
nvim_lsp.pyright.setup {
  cmd = {
    "/Users/development/.asdf/installs/nodejs/14.15.4/.npm/bin/pyright-langserver", "--stdio"
  },
}

-- }}}

-- {{{ Golang official gopls language server
-- See: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-v050
nvim_lsp.gopls.setup {
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

