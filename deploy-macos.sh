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
ln -svf $PWD/oh-my-zsh/themes/agnoster-mh.zsh-theme     ~/.oh-my-zsh/custom/themes/agnoster-mh.zsh-theme
ln -svf $PWD/submodules/zsh-nix-shell                   ~/.oh-my-zsh/custom/plugins/nix-shell

# TODO: Editors.sus
