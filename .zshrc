# vim:fileencoding=utf-8:ft=conf:foldmethod=marker

# Powerlevel10k {{{
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# }}}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# omz - ZSH and ZSH CUSTOM DIR paths {{{
# Path to your oh-my-zsh installation.
export ZSH="/Users/dev/.config/omz"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.config/omz-custom
#}}}

# omz - Update behavior {{{
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7
# }}}

# omz - Zsh prompt theme {{{
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="spaceship-prompt/spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# }}}

# omz - Case and hyphen sensitivity {{{
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# }}}

# omz - Miscellaneous {{{
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
# }}}

# omz - Plugins {{{
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Aliases are defined as plugins too.
# For a full list of active aliases, run `alias`.
plugins=(asdf colored-man-pages my-aliases kitty-autocompletion zsh-syntax-highlighting zsh-autosuggestions vi-mode osx)
# }}}

source $ZSH/oh-my-zsh.sh

# User configuration - basically `exports` and p10k shell command {{{

# MANPATH {{{
# Some apps such gdisk, sgdisk and cgdisk uses this path for man locations 
export MANPATH="/usr/local/man:$MANPATH"
# }}}

# Environment language {{{
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# }}}

# Default editor {{{
# Preferred editor for local and remote sessions
export EDITOR='vim'
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='mvim'
#fi
#}}}

# Compilation flags {{{
# export ARCHFLAGS="-arch x86_64"
# }}}

# Flutter {{{
export INTEL_HAXM_HOME="/usr/local/Caskroom/intel-haxm"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
# }}}

# Homebrew options {{{
# Disable Homebrew analytics & add security
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha
# }}}

# Pipenv {{{
export PIPENV_VENV_IN_PROJECT="enabled"
# }}}

# /usr/local/sbin {{{
# /usr/local/sbin is for system administration programs (which are not part of the core OS)
# that a local administrator may run.
# By default, a normal user does not have /usr/local/sbin on their path.
# Example: Unbound --> https://github.com/NLnetLabs/unbound
export PATH="/usr/local/sbin:$PATH"
# }}}

# gnup grep
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# Postgresql 11
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.config/p10k/p10k.zsh.
[[ ! -f ~/.config/p10k/p10k.zsh ]] || source ~/.config/p10k/p10k.zsh
# }}}