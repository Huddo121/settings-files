# Install with nix-env -f packages.nix -i
with import <nixpkgs> {
  config = { allowUnfree = true; };
};
[
  # Chat apps
  slack
  discord

  # Basic dev tools
  vscode
  idea.idea-ultimate
  emacs
  nginx

  # Terminal Emulator Stuff
  tmux
  kitty
  zsh
  oh-my-zsh
  htop

  # Miscellaneous utilities
  bat # better-cat

  # Media software
  audacity
  obs-studio
  steam
  vlc
  pavucontrol

  # Assorted tools
  super-user-spark
  ispell

  # Themes
  numix-solarized-gtk-theme
  numix-cursor-theme
]
