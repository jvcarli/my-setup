# Powerlevel10k (p10k) config

[Powerlevel10k](https://github.com/romkatv/powerlevel10k) custom configuration directory.

## Install

p10k **IS NOT** installed/managed using [Homebrew](https://brew.sh) package manager. Instead, it was installed with `git`, as an [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) plugin:

`$ git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`

Currently, it is being managed as a `git submodule` with [Yadm dotfile manager](https://github.com/TheLocehiliosan/yadm).

## Updating

For updating it with `yadm` use the command:

`yadm pull --recurse-submodules`

**IMPORTANT:** Restart Zsh after updating Powerlevel10k. [**DO NOT** use source ~/.zshrc.](https://github.com/romkatv/powerlevel10k#weird-things-happen-after-typing-source-zshrc)

## Configuration

The default directory/file for Powerlevel10k is $HOME/.p10k.zsh. This was overwritten by `POWERLEVEL9K_CONFIG_FILE` [environment variable](https://github.com/romkatv/powerlevel10k/issues/967) by running the command:

`$ POWERLEVEL9K_CONFIG_FILE=$HOME/.config/p10k/p10k.zsh p10kconfigure`

After the initial setup this variable can be safely ignored. Powerlevel10k will remember the config file location.
