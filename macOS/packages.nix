# Install with nix-env -f packages.nix -i
with import <nixpkgs> {
  config = { allowUnfree = true; };
};
[
  # Developer Tools
  # neovim # Also broken for some reason

  # Terminal stuff
  oh-my-zsh

  # Miscellaneous utilitiesx
  bat # better-cat
]

