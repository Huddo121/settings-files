# Install with nix-env -f packages.nix -i
with import <nixpkgs> {
  config = { allowUnfree = true; };
};
[
  # Configuration/System Management
  #super-user-spark # This is broken for some reason

  # Developer Tools
  vscode
  # neovim # Also broken for some reason

  # Terminal Software
  # iterm2 # Might need XCode to be installed
  oh-my-zsh
  zsh

  # Miscellaneous utilities
  bat # better-cat

  # Media software
]

