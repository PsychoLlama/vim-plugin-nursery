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

    vim-nand2tetris = {
      url = "github:sevko/vim-nand2tetris-syntax/master";
      flake = false;
    };

    yajs-vim = {
      url = "github:othree/yajs.vim";
      flake = false;
    };

    nginx-vim = {
      url = "github:chr4/nginx.vim";
      flake = false;
    };

    vim-jsx = {
      url = "github:mxw/vim-jsx";
      flake = false;
    };

    # TODO: Find a better markdown previewer.
    godown-vim = {
      url = "github:davinche/godown-vim";
      flake = false;
    };

    # TODO: Make this plugin less shameful.
    navitron-vim = {
      url = "github:PsychoLlama/navitron.vim";
      flake = false;
    };

    # --- Nursery ---

    clippy-nvim = {
      url = "path:nursery/clippy.nvim";
      flake = false;
    };

    git-vim = {
      url = "path:nursery/git.vim";
      flake = false;
    };

    misc-vim = {
      url = "path:nursery/misc.vim";
      flake = false;
    };

    stacktrace-vim = {
      url = "path:nursery/stacktrace.vim";
      flake = false;
    };
  };

  outputs = {
    self, nixpkgs, further-vim, teleport-vim, alternaut-vim,
    vim-nand2tetris, yajs-vim, nginx-vim, vim-jsx, godown-vim,
    navitron-vim, clippy-nvim, git-vim, misc-vim, stacktrace-vim,
  }:

  let
    buildPlugin = system: plugin:
      let inherit (nixpkgs.legacyPackages.${system}) vimUtils;
      in vimUtils.buildVimPluginFrom2Nix plugin;

    buildAllPlugins = system: _: builtins.mapAttrs
      (pluginName: plugin: buildPlugin system {
        pname = pluginName;
        version = plugin.rev or self.rev or "dirty";
        src = plugin;
      })
      {
        inherit further-vim teleport-vim alternaut-vim vim-nand2tetris;
        inherit yajs-vim nginx-vim vim-jsx godown-vim navitron-vim;
        inherit clippy-nvim git-vim misc-vim stacktrace-vim;
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
