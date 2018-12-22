# Install with nix-env -f packages.nix -i
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
  postman

  # Terminal Emulator Stuff
  tmux
  kitty
  zsh
  oh-my-zsh
  htop

  # Miscellaneous utilities
  # solaar # Logitech unifying receiver software
  gucharmap
  flameshot

  # Media software
  discord
  obs-studio
  steam
  vlc
  pavucontrol

  # Assorted tools
  gnome3.nautilus
  gthumb
  lxappearance # Doesn't work for GTK2 out of the box
  super-user-spark
  ispell

  # Themes
  numix-solarized-gtk-theme
  numix-cursor-theme

  # Gnome Extensions
  # gnomeExtensions.impatience
  # gnomeExtensions.system-monitor
  # gnomeExtensions.nohotcorner
]
