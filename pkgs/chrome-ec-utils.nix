{ lib, stdenv, fetchFromGitHub, pkgconfig, libftdi, libusb1 }:

stdenv.mkDerivation rec {
  name = "chrome-ec-utils";

  src = fetchFromGitHub {
    owner = "MrChromebox";
    repo = "chrome-ec";

    # Branch: firmware-samus-6300.B
    # But before a commit that removed these tool targets:
    # a5ddef88fbdf8b97533c0eebc2ce8d9e57aa479d
    rev = "84f7b3e60d7e4956350326d4552425f630336659";
    sha256 = "sha256-669CqKdB+0OYKabr9P2AU9PIYE5dkI6xcRpT2/AZSHA=";
  };

  buildInputs = [ libftdi libusb1 ];

  nativeBuildInputs = [ pkgconfig ];

  preConfigure = ''
    patchShebangs util
  '';

  NIX_CFLAGS_COMPILE = "-Wno-error";

  buildPhase = ''
    make HOST_CROSS_COMPILE= utils-host
  '';

  installPhase = ''
    mkdir $out/bin
    cp $out/util/{ec_sb_firmware_update,ectool,lbcc,lbplay,stm32mon} $out/bin
  '';

  meta = with lib; {
    description = "Chromium OS Embedded Controller host tools";
    homepage = "https://chromium.googlesource.com/chromiumos/platform/ec";
    license = licenses.bsd2;
    maintainers = with maintainers; [ mirrexagon ];
  };
}

