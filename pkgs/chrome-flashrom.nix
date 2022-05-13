{ lib, stdenv, fetchgit, pkgconfig, libftdi1, libusb1, pciutils }:

stdenv.mkDerivation rec {
  name = "chrome-flashrom";

  src = fetchgit {
    url = "https://chromium.googlesource.com/chromiumos/third_party/flashrom";
    rev = "8401ef7702778a6ba8fec6285adcdc82d0203916";
    sha256 = "sha256-qoQAiqLb9ffmsC64+4HfiWOc/iC7ddD/BYkmbbfshag=";
  };

  buildInputs = [ libftdi1 libusb1 pciutils ];

  nativeBuildInputs = [ pkgconfig ];

  preConfigure = ''
    substituteInPlace Makefile \
      --replace 'FEATURE_CFLAGS' 'FEATURE_FLAGS'
  '';

  makeFlags = [ "PREFIX=$(out)" ];

  meta = with lib;
    {
      description = "Chromium OS fork of the Flashrom tool";
      homepage = "https://chromium.googlesource.com/chromiumos/third_party/flashrom";
      license = licenses.gpl2Plus;
      maintainers = with maintainers; [ mirrexagon ];
    };
}

