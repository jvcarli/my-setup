-- debugpy MUST be installed insed dap-python venv: `pip install debugpy` inside it
-- See: https://github.com/mfussenegger/nvim-dap-python
-- not working from here
return require'dap-python'.setup('/Users/development/.config/nvim/debug-adaptors/debugpy/venv/bin/python')

-- TODO: configure dap
-- See: https://www.reddit.com/r/neovim/comments/ljmpcc/nvimdap/
-- See: https://github.com/David-Kunz/vim
