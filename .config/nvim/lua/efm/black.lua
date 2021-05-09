-- taken from: https://github.com/cigrainger/cfg/blob/main/.config/nvim/lua/efm/black.lua 
-- taken from: https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/efm/black.lua
return {
    formatCommand = "black -",
    -- black fast mode can be invoked too:
    -- formatCommand = "black --fast -",
    formatStdin = true
}
