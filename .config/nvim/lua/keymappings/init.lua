-- emmet-vim
-- see: https://github.com/mattn/emmet-vim
-- Redefine emmet-vim trigger key
-- Note that the trailing `,` (comma) still needs to be entered
-- so <C-S> will be `ctrl + s > ,`
vim.g.user_emmet_leader_key='<C-S>'

-- SirVer/ultisnips
-- ultisnips has a TERRIBLE lag in neovim
-- see: https://github.com/SirVer/ultisnips
-- see: https://github.com/SirVer/ultisnips/issues/801
-- vim.g.UltiSnipsExpandTrigger='<tab>'

-- TODO: add CmdlineComplete shortcuts
-- https://github.com/vim-scripts/CmdlineComplete
-- https://www.vim.org/scripts/script.php?script_id=2222
-- If you want to use other keys instead of default <c-p> <c-n>, you may say in your .vimrc
-- cmap <c-y> <Plug>CmdlineCompleteBackward
-- cmap <c-e> <Plug>CmdlineCompleteForward
-- this will use Ctrl-Y for search backward and Ctrl-E for search forward.
-- 
-- Note: I don't think it's good to use Tab and Shift-Tab for completion, since it will disable vim's original cmdline-completion.

-- Trouble.nvim
-- https://github.com/folke/trouble.nvim
-- Toggle Trouble with `Leader > e` keys
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>TroubleToggle<CR>", {noremap = true, silent = true}
)

-- barbar.nvim
vim.api.nvim_set_keymap("n", "[b", ":BufferNext<CR>", { noremap=true, silent = true })

-- openbrowser ("n": normal mode, "v": visual mode)
vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", {noremap = false})
vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", {noremap = false})

-- sneakvim
-- See: https://www.reddit.com/r/neovim/comments/jwd0qx/how_do_i_define_vim_variable_in_lua/
vim.g["sneak#label"] = 1

-- Barbar
--  Move to previous/next
vim.api.nvim_set_keymap("n", "<A-,>", ":BufferPrevious<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-.>", ":BufferNext<CR>", {silent = true} )

--  Re-order to previous/next
-- TODO: remap kitty shortcuts that are conflicting with this
vim.api.nvim_set_keymap("n", "<A-<>", ":BufferMovePrevious<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A->>", ":BufferMoveNext<CR>", {silent = true} )

-- Close buffer
vim.api.nvim_set_keymap("n", "<A-c>", ":BufferClose<CR>", {silent = true} )

-- Goto buffer in position...
vim.api.nvim_set_keymap("n", "<A-1>", ":BufferGoto 1<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-2>", ":BufferGoto 2<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-3>", ":BufferGoto 3<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-4>", ":BufferGoto 4<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-5>", ":BufferGoto 5<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-6>", ":BufferGoto 6<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-7>", ":BufferGoto 7<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-8>", ":BufferGoto 8<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-9>", ":BufferGoto 9<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-0>", ":BufferLast<CR>", {silent = true})

-- nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
-- nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>

-- Undotree
vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", {silent=true})

-- TODO: add command to toggle `:nohlsearch`
-- there's one plugin that enhances hlsearch and solves this 
-- this will remove the highlighting of searched matches

-- TODO: integrate awesome wm - for when working on linux
-- see: https://github.com/intrntbrn/awesomewm-vim-tmux-navigator

