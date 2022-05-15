{ lib, stdenv, fetchgit, pkgconfig, libftdi, libusb1 }:

stdenv.mkDerivation rec {
  name = "chrome-ec-utils";

  src = fetchgit {
    url = "https://chromium.googlesource.com/chromiumos/platform/ec";
    rev = "3ac4093e2caeb2ec9fdaa3cbc0112d3e61461d7e";
    sha256 = "sha256-weBh7s6R8LRwBPjgqnd69MAlH1Rp2ES1K13YoWh1eto=";
  };

  buildInputs = [ libftdi libusb1 ];

  nativeBuildInputs = [ pkgconfig ];

  preConfigure = ''
    patchShebangs util
  '';

  NIX_CFLAGS_COMPILE = "-Wno-error";

  makeFlags = [ "HOST_CROSS_COMPILE=" "utils-host" ];

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

