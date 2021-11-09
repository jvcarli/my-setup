#!/usr/bin/env bash

# Stow all directories in this directory
# TODO: change install script so it works from anywhere
for directory in */; do
    stow -D "$directory" # unstow directories before stowing
    stow "$directory"
done
