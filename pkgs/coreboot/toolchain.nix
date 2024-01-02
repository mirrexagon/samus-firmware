# TODO:
# - Look at https://maxwell.ydns.eu/git/rnhmjoj/nixboot
# - Make separate flake for building Coreboot
# - Don't use gen-sources.sh. determine all that in the toolchain derivation from the original source

{ lib, stdenv, fetchFromGitHub, gnat11, ncurses, m4, flex, bison, zlib, pkg-config, curl, git }:

stdenv.mkDerivation rec {
  name = "coreboot-toolchain-i386";

  src = import ./source.nix { inherit fetchFromGitHub; };

  buildInputs = [
  ];

  nativeBuildInputs = [
    gnat11 # gcc with ada
    #gnatboot # gnat1
    ncurses # make menuconfig
    m4
    flex
    bison # Generate flashmap descriptor parser
    #clang
    zlib
    #acpica-tools # iasl
    pkg-config
    curl
    git
  ];

  makeFlags = [ "crossgcc-i386" ];

  enableParallelBuilding = true;

  installPhase = ''
    # TODO
  '';

  meta = with lib; {
    description = "Coreboot i386 toolchain (from MrChromebox fork)";
    homepage = "https://github.com/MrChromebox/coreboot";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ mirrexagon ];
  };
}

