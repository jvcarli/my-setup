# Adapted from:
# https://github.com/asdf-community/asdf-direnv
# https://github.com/direnv/direnv/blob/master/docs/hook.md#zsh

# Hook direnv into your shell.
eval "$(asdf exec direnv hook zsh)"

# A shortcut for asdf managed direnv.
direnv() { asdf exec direnv "$@"; }
