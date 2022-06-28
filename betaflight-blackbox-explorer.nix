# The explorer seems to use more stuff than just the NW.js chromium wrapper so we patch its binary directly
{ alsa-lib
, at-spi2-atk
, atk
, autoPatchelfHook
, cairo
, cups
, dbus
, expat
, fetchurl
, glib
, gtk3
, lib
, libdrm
, libGL
, libXcomposite
, libXdamage
, libXext
, libXfixes
, libXrandr
, libxkbcommon
, makeWrapper
, mesa
, nss
, pango
, src
, stdenv
, udev
}:
stdenv.mkDerivation rec {
  pname = "betaflight-blackbox-explorer";
  version = "3.6.0";
  nativeBuildInputs = [
    alsa-lib
    at-spi2-atk
    atk
    autoPatchelfHook
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libGL
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    libxkbcommon
    makeWrapper
    mesa
    nss
    pango
    udev
  ];

  LD_LIBRARY_PATH=lib.makeLibraryPath nativeBuildInputs;
  inherit src;
  installPhase = ''
    mkdir -p $out/bin
    cp -r . $out
    makeWrapper $out/betaflight-blackbox-explorer $out/bin/betaflight-blackbox-explorer --set LD_LIBRARY_PATH ${LD_LIBRARY_PATH}
  '';
}
