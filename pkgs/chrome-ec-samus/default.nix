{ lib, stdenv, fetchFromGitHub, gcc-arm-embedded }:

stdenv.mkDerivation rec {
  name = "chrome-ec-samus";

  src = fetchFromGitHub {
    owner = "MrChromebox";
    repo = "chrome-ec";

    # Branch: firmware-samus-6300.B
    rev = "d535b004276b6d7a4005a0b255cec9c5f5a7acfa";
    sha256 = "sha256-3T1yFPyh+F9NWGtV3Ocubj+NX+3aAGd527U4LveyXbk=";
  };

  nativeBuildInputs = [ gcc-arm-embedded ];

  patches = [ ./Remove-Werror.patch ./Remove-inline-specifier-from-interrupt-context-funct.patch ];

  preConfigure = ''
    patchShebangs util
  '';

  NIX_CFLAGS_COMPILE = "-Wno-error";

  buildPhase = ''
    make HOST_CROSS_COMPILE= BOARD=samus
  '';

  installPhase = ''
    # Coincidentally, the EC build system outputs build artifacts to $out, so we
    # don't need to do anything here.
    # It does mean that all build outputs end up in the derivation output, but
    # for now it doesn't matter - the desired ec.bin is there.
  '';

  meta = with lib; {
    description = "Chromium OS Embedded Controller firmware for samus (Google Chromebook Pixel 2015)";
    homepage = "https://chromium.googlesource.com/chromiumos/platform/ec";
    license = licenses.bsd2;
    maintainers = with maintainers; [ mirrexagon ];
  };
}

