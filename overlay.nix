final: prev: {
  chrome-ec-utils = prev.callPackage ./pkgs/chrome-ec-utils.nix { };
  chrome-ec-samus = prev.callPackage ./pkgs/chrome-ec-samus { };
}
