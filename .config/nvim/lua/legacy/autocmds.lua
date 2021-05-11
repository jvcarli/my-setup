-- Vim commands that weren't ported to lua already

-- autocmds
-- Commands inside vim.cmd are coded with vimscript because
-- augroups and autocommands DO NOT have an interface yet,
-- but is being worked on, see: https://github.com/neovim/neovim/pull/12378

-- =======================================--
--     Tabs and spaces configuration      --
-- =======================================--

-- Golang
vim.cmd [[autocmd FileType go setlocal noexpandtab]] -- gofmt uses booth spaces and tabs so tabs won't be expanded as one normaly would like to
-- Typescript JSX
vim.cmd[[autocmd FileType typescriptreact setlocal softtabstop=2 shiftwidth=2 expandtab]]
-- Typescrpt 
vim.cmd[[autocmd FileType typescript setlocal softtabstop=2 shiftwidth=2 expandtab]]
-- Javascript
vim.cmd[[autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2 expandtab]]
-- Html
vim.cmd[[autocmd FileType html setlocal softtabstop=2 shiftwidth=2 expandtab]]
-- Svelte
vim.cmd[[autocmd FileType svelte setlocal softtabstop=2 shiftwidth=2 expandtab]]

-- =======================================--
--                 Packer                 --
-- =======================================--

-- Packer
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

-- =======================================--
--                quick-scope             --
-- =======================================--
-- TODO: configure good colors for quick-scope plugin
-- vim.cmd [[autocmd VimEnter * highlight QuickScopePrimary gui=bold guifg=NONE]]
-- vim.cmd [[autocmd VimEnter * highlight QuickScopeSecondary gui=bold guifg=NONE]]

