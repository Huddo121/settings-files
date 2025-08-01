# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster-mh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(gitfast docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Nix-shell extension for ZSH
. $ZSH_CUSTOM/plugins/nix-shell/nix-shell.plugin.zsh

# Set up completions
fpath=(/usr/local/share/zsh/site-functions /usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit

# Stop sharing history between different terminal windows
unsetopt share_history

# Common Environment Variables
export JAVA_OPTIONS="-Xms4096m -Xmx4096m -XX:MaxMetaspaceSize=1024m"

# Set up aliases for making my life easier
alias gcm='() {
  git commit -m $@
;}'

alias gpa='() {
  git add . && gcm $@ && git push
;}'

alias gpom='git pull origin master'

# Function to start a child shell with Infisical secrets and environment indicator
infisical-shell() {
    local project=$1
    local env_name=$2
    local display_name=${3:-${env_name:u}}  # Use uppercase version if display name not provided

    if [[ -z "$env_name" ]]; then
        echo "Usage: infisical-shell <environment> [display_name]"
        echo "Example: infisical-shell dev"
        echo "Example: infisical-shell production PROD"
        return 1
    fi

    # Export secrets and set environment indicator
    local secrets_export
    secrets_export=$(infisical export --projectId="$project" --env="$env_name" --format=dotenv-export 2>/dev/null)

    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to load secrets for environment '$env_name'"
        return 1
    fi

    # Start child shell with secrets and environment indicator
    env SECRET_ENV_NAME="$display_name" SECRET_ENV_TYPE="$env_name" \
        bash -c "$secrets_export; exec zsh"
}

# Loads up the secrets for Contexts production from my infisical instance
ctxprod() {
    infisical-shell "9e13fac1-808e-440b-80e6-19d1995bf7ea" prod "CTX-PROD"
}

# Load some OS-specific config
. $HOME/.machinerc

# Use vim (or neovim) as the default system editor
export EDITOR=vim

if [ -s "$NVM_DIR/bash_completion" ]
then
    source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [ -f "/Users/mhudson/.ghcup/env" ]
then
    source "/Users/mhudson/.ghcup/env" # ghcup-env
fi


fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/mhudson/.lmstudio/bin"
# End of LM Studio CLI section

