# Completion for Kitty

# The important thing below is to make sure the call to Kitty 
# to load the zsh completions happens **after** the call to compinit.
# This is ALREADY PROVIDED by oh-my-zsy framework.

# autoload -Uz compinit
# compinit
kitty + complete setup zsh | source /dev/stdin
