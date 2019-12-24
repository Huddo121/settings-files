# settings-files
A series of settings and configuration files so that I can jump between machines with ease. This is what some people may traditionally call a dotfiles repo.

This project uses git submodules for some functionality, clone this repo using `git clone --recurse-submodules` to get the best experience.

# [Nix](https://nixos.org/nix/)
Software is installed using [the Nix package manager](https://nixos.org/nix/). Nix can be used to bootstrap the installation of this repo, by running the appropriate command for your operating system.

```
nix-env -i -f macOS/packages.nix
nix-env -i -f nixos/packages.nix
```

# Super-User-Spark
Configuration deployments are managed using [Super-User-Spark](https://github.com/NorfairKing/super-user-spark). Not all [cards](https://cs-syd.eu/posts/2015-10-11-super-user-spark-blocks-and-cards) are able to be deployed on all systems. A [nixos.sus](./nixos.sus), [linux.sus](./linux.sus), and [macOS.sus](./macOS.sus) card are included for convenience.

```
spark deploy {macOS|linux|nixos}.sus
```

# Oh-my-zsh
Oh-my-zsh will need to be installed before attempting to spark a file relying on the `zsh.sus` card.

# zsh-nix-shell
The standard nix-shell is quite uncomfortable to use once you're used to ZSH and oh-my-zsh. [zsh-nix-shell](https://github.com/chisui/zsh-nix-shell) is included as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) under the [oh-my-zsh](./oh-my-zsh) directory, and so it's recommended to clone this repo with `git clone --recurse-submodules` or `git submodule init && git submodule update` if you've already cloned the repo. After doing so you can redeploy the zsh card with `spark deploy zsh.sus`.
