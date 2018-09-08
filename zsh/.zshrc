
# Neko Config ZSH setup. Requires oh-my-zsh to run. You can get it via this command:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Feeling like you don't have curl? You can use wget to download it as well!
# sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Quick command to check if a program exists.
exists() { [ -x "$(command -v $1)" ]; }

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

#Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="nekoshell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Note: I have some plugins like OSX and Arch. You probably don't need these.
plugins=(git rust pyenv pip ruby rails arch osx zsh-autosuggestions zsh-syntax-highlighting zsh-256color command-time zsh-syntax-highlighting-filetypes)

# To install the plugins from my custom setup simply "source plugins.sh".

source $ZSH/oh-my-zsh.sh

# Load custom aliases from a designated file.
if [[ ! -a $HOME/.zsh_aliases ]]; then
    touch $HOME/.zsh_aliases
else
    source $HOME/.zsh_aliases
fi

# Load custom paths from a desginated file.
if [[ ! -a $HOME/.zsh_path ]]; then
    touch $HOME/.zsh_path
else
    source $HOME/.zsh_path
fi

# You may need to manually set your language environment
# Don't forget to uncomment the locale in /etc/locale.gen and run locale-gen as root
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if exists vim; then
    if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
    else
        export EDITOR='mvim'
    fi
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Custom key bindings go in this section.
bindkey "[C" forward-word
bindkey "[D" backward-word

# Base16 Shell support. Install via: git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
# Don't forget to set your theme via base16 and tab completion. I personally use base16_neko which is a fork of base16_seti.
BASE16_SHELL=$HOME/.config/base16-shell/
[[ -n $PS1 ]] && [[ -s $BASE16_SHELL/profile_helper.sh ]] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Custom dircolors setup.
if whence dircolors > /dev/null; then
    eval $(dircolors -b "$HOME/.dircolors")
    alias ls='ls --color'

else
    export CLICOLOR=1
    source ~/.osxcolors
fi

# Colored completion - use LS_COLORS.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Replace default ls commands with exa's.
if exists exa; then
    alias ls="exa"
    alias la="exa -laagh --git"
fi

# Fix issues relating to GPG key signing.
GPG_TTY=$(tty)
export GPG_TTY

# Create an extra alias just for pasting. Uses netcat if available.
# Example: echo You can now paste like this! | tb
if exists nc; then
    alias tb="nc termbin.com 9999"
    
else
    alias tb="(exec 3<>/dev/tcp/termbin.com/9999; cat >&3; cat <&3; exec 3<&-)"
fi
