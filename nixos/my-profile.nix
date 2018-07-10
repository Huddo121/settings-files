# Install with nix-env -f my-profile.nix -i
with import <nixpkgs> { 
  config = { allowUnfree = true; };
};
[ 
  # Web-stuff
  firefox
  
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
  # solaar # Logitech unifying receiver software

  # Media software
  discord
  obs-studio
  steam
  vlc

  # Gnome Extensions
  # gnomeExtensions.impatience 
  # gnomeExtensions.system-monitor
  # gnomeExtensions.nohotcorner
]
