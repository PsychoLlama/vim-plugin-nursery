{
  description = "A sandbox for developing experimental vim plugins";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    # TODO: Put these in nixpkgs.
    further-vim = {
      url = "github:PsychoLlama/further.vim/master";
      flake = false;
    };

    teleport-vim = {
      url = "github:PsychoLlama/teleport.vim/master";
      flake = false;
    };

    alternaut-vim = {
      url = "github:PsychoLlama/alternaut.vim/main";
      flake = false;
    };

    navitron-nvim = {
      url = "github:PsychoLlama/navitron.vim/main";
      flake = false;
    };

    vim-nand2tetris = {
      url = "github:sevko/vim-nand2tetris-syntax/master";
      flake = false;
    };

    nginx-vim = {
      url = "github:chr4/nginx.vim";
      flake = false;
    };

    unison-vim = {
      url = "github:unisonweb/unison";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, further-vim, teleport-vim, alternaut-vim
    , navitron-nvim, vim-nand2tetris, nginx-vim, unison-vim }:

    let
      buildPlugin = system: plugin:
        let inherit (nixpkgs.legacyPackages.${system}) vimUtils;
        in vimUtils.buildVimPluginFrom2Nix plugin;

      buildAllPlugins = system: _:
        builtins.mapAttrs (pluginName: plugin:
          buildPlugin system {
            pname = pluginName;
            version = plugin.rev or self.rev or "dirty";
            src = plugin;
          }) {
            inherit further-vim teleport-vim alternaut-vim navitron-nvim
              vim-nand2tetris nginx-vim;
            unison-vim = "${unison-vim}/editor-support/vim";
          };

    in {
      packages = builtins.mapAttrs buildAllPlugins {
        "x86_64-linux" = null;
        "i686-linux" = null;
        "x86_64-darwin" = null;
        "aarch64-linux" = null;
        "armv6l-linux" = null;
        "armv7l-linux" = null;
        "aarch64-darwin" = null;
      };

      overlay = final: prev: {
        vimPlugins = prev.vimPlugins // self.packages.${final.system};
      };
    };
}
