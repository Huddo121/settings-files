
export NVM_DIR="/Users/mhudson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

NIX_BOOTSTRAP=$HOME/.nix-profile/etc/profile.d/nix.sh
if [ -e $NIX_BOOTSTRAP ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
