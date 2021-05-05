{ pkgs ? import <nixpkgs> {} }:

let
  plugins =
    let entries = builtins.readDir ./.;
    pluginDirectory = builtins.toString ./.;
    pluginNames = builtins.filter (entryName: builtins.getAttr entryName entries == "directory") (builtins.attrNames entries);
    intoPlugin = name: { inherit name; path = /. + (pluginDirectory + "/" + name); };
    in map intoPlugin pluginNames;

  wrapPlugin = { name, path }: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nursery-${builtins.replaceStrings ["."] ["-"] name}";
    version = "latest";
    src = path;
  };

in map wrapPlugin plugins