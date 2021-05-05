# Vim Plugin Nursery
A custom nix channel serving experimental vim plugins.

## Purpose
One of my few joys is writing vim plugins, but not every idea is a good one. I need a place to experiment without fully committing to a new repository.

Additionally, this functions as a custom [nix](https://nixos.org/) channel serving my vim plugins. The less polished ones don't belong in [nixpkgs](https://github.com/NixOS/nixpkgs) yet.

Feel free to copy anything that looks interesting, but be warned that it's mostly alpha quality.

## Usage
Add a custom nix channel:

```sh
nix-channel --add https://github.com/PsychoLlama/vim-plugin-nursery/archive/main.tar.gz vim-plugins
nix-channel --update vim-plugins
```

Then you can use it in your nix file:

```nix
let vim-plugins = import <vim-plugins> {};

in neovim.override {
  packages.personal.start = [ vim-plugins.yourCustomPlugin ];
}
```
