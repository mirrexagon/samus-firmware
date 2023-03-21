{ lib, stdenv, meson, ninja, fetchgit, pkgconfig, libftdi1, libusb1, pciutils, cmocka, sphinx }:

stdenv.mkDerivation rec {
  name = "chrome-flashrom";

  src = fetchgit {
    url = "https://chromium.googlesource.com/chromiumos/third_party/flashrom";
    rev = "bf4cc23d9bc616141e4c94ae491d7e9614e02b10";
    sha256 = "sha256-UfYbw4PmTXZpMAZeon1GRjseMvgo394N33OVjXuy930=";
  };

  buildInputs = [ libftdi1 libusb1 pciutils ];

  nativeBuildInputs = [ pkgconfig meson ninja cmocka sphinx ];

  meta = with lib;
    {
      description = "Chromium OS fork of the Flashrom tool";
      homepage = "https://chromium.googlesource.com/chromiumos/third_party/flashrom";
      license = licenses.gpl2Plus;
      maintainers = with maintainers; [ mirrexagon ];
    };
}

