config@{ pkgs ? import <nixpkgs> config }:

with pkgs;

let
  pluginManifest =
    let lockfile = builtins.fromJSON (builtins.readFile ./lockfile.json);
    in lockfile.plugins;

    vimPluginFromDefinition = plugin: vimUtils.buildVimPluginFrom2Nix {
      pname = builtins.replaceStrings ["."] ["-"] plugin.repo;
      version = plugin.version;
      meta.homepage = plugin.homepage;

      src = fetchFromGitHub {
        owner = plugin.owner;
        repo = plugin.repo;
        rev = plugin.rev;
        sha256 = plugin.hash;
        fetchSubmodules = true;
      };
    };

in map vimPluginFromDefinition pluginManifest
