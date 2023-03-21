# ,- Verbosely create a symbolic link
# |      ,- To this file
# |      |                                                ,- Accessible from this file
# v      v                                                v
ln -svf $PWD/macOS/.machinerc                           ~/.machinerc

# VS Code settings
ln -svf $PWD/vscode/settings.json                       ~/Library/Application\ Support/Code/User/settings.json
ln -svf $PWD/macOS/vscode-keybindings.json              ~/Library/Application\ Support/Code/User/keybindings.json

# ZSH
ln -svf $PWD/oh-my-zsh/.zshrc                           ~/.zshrc
ln -svf $PWD/oh-my-zsh/.zprofile                        ~/.zprofile

mkdir -p ~/.oh-my-zsh/custom/themes
mkdir -p ~/.oh-my-zsh/custom/plugins

ln -svf $PWD/oh-my-zsh/themes/agnoster-mh.zsh-theme     ~/.oh-my-zsh/custom/themes/agnoster-mh.zsh-theme
# TODO: Linking to a directory like this results in re-runs creating recursive folders
ln -svf $PWD/submodules/zsh-nix-shell                   ~/.oh-my-zsh/custom/plugins/nix-shell

# Other editor files
mkdir -p ~/.config
ln -svf $PWD/.config/nvim/init.vim                      ~/.config/nvim/init.vim

mkdir -p ~/.local/share/nvim/site/autoload
ln -svf $PWD/submodules/vim-plug/plug.vim               ~/.local/share/nvim/site/autoload
