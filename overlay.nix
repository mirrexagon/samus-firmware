final: prev: {
  chrome-ec-utils = prev.callPackage ./pkgs/chrome-ec-utils.nix { };
  chrome-flashrom = prev.callPackage ./pkgs/chrome-flashrom.nix { };
  chrome-ec-samus = prev.callPackage ./pkgs/chrome-ec-samus { };
}
