# Vim Plugin Nursery
A custom nix channel serving experimental vim plugins.

## Purpose
One of my few joys is writing vim plugins, but not every idea is a good one. I need a place to experiment without fully committing to a new repository.

Plugins are distributed through a [Nix flake](https://nixos.wiki/wiki/Flakes). I guess you could also install them through vim-plug, but remember it's called "vim-plugin-nursery" - they're all alpha quality.

Additionally, this repo serves as a place to build plugins that haven't made their way into [nixpkgs](https://github.com/NixOS/nixpkgs) yet. I should add them upstream instead. Meh.

The flake lockfile updates every Monday.

## Usage

**Nix**

```nix
{
  inputs.nursery.url = "github:PsychoLlama/vim-plugin-nursery/main";

  outputs = { self, nursery, nixpkgs }:

  let system = "x86_64-linux";
  in with import nixpkgs {
    overlays = [nursery.overlay];
    inherit system;
  };

  {
    defaultPackage.${system} = neovim.override {
      configure.packages.personal.start = [
        # Optional: The overlay adds all plugins from the nursery to nixpkgs.vimPlugins.
        vimPlugins.further-vim

        # Or, pull them off `packages` instead.
        nursery.packages.${system}.stacktrace-vim
      ];
    };
  };
}
```

**vim-plug**

```vim
Plug 'PsychoLlama/vim-plugin-nursery', { 'rtp': 'plugins/{plugin-name}.vim' }
```
