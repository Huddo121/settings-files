NIX_BOOTSTRAP=$HOME/.nix-profile/etc/profile.d/nix.sh
if [ -e $NIX_BOOTSTRAP ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi
