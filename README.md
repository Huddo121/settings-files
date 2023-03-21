# settings-files
A series of settings and configuration files so that I can jump between machines with ease. This is what some people may traditionally call a dotfiles repo.

This project uses git submodules for some functionality, clone this repo using `git clone --recurse-submodules` to get the best experience, or `git submodule init && git submodule update` if you've already cloned the repo.

# Setting up config

* **macOS:** `./deploy-macos.sh`
* **TODO:** Linux

# [Nix](https://nixos.org/nix/)
Software is installed using [the Nix package manager](https://nixos.org/nix/). Nix can be used to bootstrap the installation of this repo, by running the appropriate command for your operating system.

```
nix-env -i -f macOS/packages.nix
nix-env -i -f nixos/packages.nix
```

# zsh-nix-shell
The standard nix-shell is quite uncomfortable to use once you're used to ZSH and oh-my-zsh. [zsh-nix-shell](https://github.com/chisui/zsh-nix-shell) is included as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) under the [oh-my-zsh](./oh-my-zsh) directory, and so it's recommended to clone this repo with `git clone --recurse-submodules` or `git submodule init && git submodule update` if you've already cloned the repo. After doing so you can redeploy the zsh card with `spark deploy zsh.sus`.
