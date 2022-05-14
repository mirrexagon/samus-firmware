final: prev: {
  chrome-flashrom = prev.callPackage ./pkgs/chrome-flashrom.nix { };

  chrome-ec-utils = prev.callPackage ./pkgs/chrome-ec-utils.nix { };
  chrome-ec-samus = prev.callPackage ./pkgs/chrome-ec-samus { };

  coreboot-toolchain-i386 = prev.callPackage ./pkgs/coreboot/toolchain.nix { };
}
