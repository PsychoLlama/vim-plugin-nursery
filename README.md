# Vim Plugin Nursery
A custom nix channel serving experimental vim plugins.

## Purpose
One of my few joys is writing vim plugins, but not every idea is a good one. I need a place to experiment without fully committing to a new repository.

Additionally, this functions as a custom [nix](https://nixos.org/) channel serving my vim plugins. The less polished ones don't belong in [nixpkgs](https://github.com/NixOS/nixpkgs) yet.

I also have a few plugins listed in the channel that haven't been added to nixpkgs yet (e.g. they're unmaintained, not ready for public use, or lesser-known plugins). They automatically refresh every week. It enables me to instantly add plugins to my vimrc without waiting on PRs to nixpkgs or manually updating hashes.

Feel free to copy anything that looks interesting, but be warned that the plugins are mostly alpha quality.

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

## Adding 3rd-Party Plugins
See [`3rd-party/plugin-names.js`](https://github.com/PsychoLlama/vim-plugin-nursery/blob/main/3rd-party/plugin-names.js). Anything added to the list is automatically generated and placed in the lockfile, which is how the nix channel gets pinned hashes and revisions. There's a cron job that refreshes them every week.

**Note:** I'm not accepting contributions. If you want to add your own plugins, I suggest a fork.
