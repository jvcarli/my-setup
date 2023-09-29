#!/bin/bash

# TODO: Stow can't be used with Windows, only with macOS and Linux.
#       Find an alternative for Windows.

# Initialize variables with default values.
install=false
clean=false
return_message=""

# Display help message for invalid options and when no arguments are given.
display_help() {
  echo -e "Usage: $0 [OPTIONS]\n"
  echo -e "Options:"
  echo -e "  --install          Install the configuration files."
  echo -e "  --clean            Remove all configuration files."
  echo -e "  --clean --install  Perform a clean-up and then install the configuration files."
  exit 1
}

# Check if any arguments are provided, and call display_help if not.
if [ $# -eq 0 ]; then
  display_help
fi

# Process command line options.
while [[ $# -gt 0 ]]; do
  case "$1" in
    --install)
      install=true
      shift
      ;;
    --clean)
      clean=true
      shift
      ;;
    *)
      display_help
      ;;
  esac
done

# Get the directory where the script is located.
script_directory="$(dirname "$0")"

# Change the current directory to the script's directory,
# so stow is executed correctly.
cd "$script_directory" || exit 1

# Use find to locate and process subdirectories in the script's directory,
# excluding those that start with '_' or '.'. Sort them alphabetically and
# remove "./" string from $directory. This is necessary to prevent stow from
# giving the error "slashes are not permitted in package names".
find . -maxdepth 1 -type d ! -name '_*' ! -name '.*' -print | sed 's|^\./||' | sort | while read -r directory; do
    if [ "$clean" = true ]; then
        echo "Unstowing directory: $directory"
        stow -D "$directory" # unstow directories
    fi
    if [ "$install" = true ]; then
        echo "Stowing directory: $directory"
        stow "$directory"
    fi
done

if [ "$install" = false ] && [ "$clean" = true ]; then
    return_message="The configuration files were removed, please restart your shell!"
fi

if [ "$install" = true ] && [ "$clean" = false ]; then
    return_message="The configuration files are installed, please restart your shell!"
fi

if [ "$install" = true ] && [ "$clean" = true ]; then
    return_message="A fresh install of the configuration files was made, please restart your shell!"
fi

# Display the return_message if not empty.
if [ -n "$return_message" ]; then
    echo -e "\n$return_message"
fi
