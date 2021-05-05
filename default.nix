config@{ pkgs ? import <nixpkgs> config }:

let
  standardPlugins = pkgs.vimPlugins;
  thirdPartyPlugins = import ./3rd-party config;
  nursery = import ./nursery config;
  extraPlugins = thirdPartyPlugins ++ nursery;
  addPlugin = plugins: plugin: plugins // { ${plugin.pname} = plugin; };

in builtins.foldl' addPlugin standardPlugins extraPlugins
