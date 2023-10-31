#!/usr/bin/env bash

# Show only git staged files

staged_files=$(git status --short | grep '^\w.')

GREEN_COLOR='\033[0;32m'
echo -e "${GREEN_COLOR} ${staged_files}"
