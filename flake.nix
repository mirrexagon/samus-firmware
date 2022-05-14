{
  description = "Custom firmware for the Google Chromebook Pixel 2015 (samus)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    overlays.default = import ./overlay.nix;
  } // flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
    let
      pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
    in
    {
      packages = {
        inherit (pkgs)
          chrome-flashrom
          chrome-ec-utils
          chrome-ec-samus
          coreboot-toolchain-i386;
      };
    });
}
