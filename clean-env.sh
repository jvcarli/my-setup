#!/usr/bin/env bash

# Unstow all directories in this directory
# TODO: change clean-env script so it works from anywhere
for directory in */; do
    echo "Unstowing $directory"
    stow -D "$directory" # unstow directories before stowing
done
