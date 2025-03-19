{
  fetchurl,
  stdenv,
  lib,
  autoPatchelfHook,
  xorg,
  gtk3,
  pango,
  at-spi2-atk,
  nss,
  libdrm,
  alsa-lib,
  mesa,
  udev,
  libappindicator,
  imagemagick,
  makeDesktopItem,
}:

let
  clash-for-windows = {
    pname = "clash-for-windows";
    version = "0.20.39";
    src = fetchurl {
      url = "https://archive.org/download/clash_for_windows_pkg/Clash.for.Windows-0.20.39-x64-linux.tar.gz";
      sha256 = "sha256-4HxeNYvOmVEcEDJiug1tAWfHAkLy5ognsJ96KRjUPcA=";
    };
  };
  clash-for-windows-icon = {
    pname = "clash-for-windows-icon";
    version = "0";
    src = fetchurl {
      url = "https://web.archive.org/web/20211210004725if_/https://docs.cfw.lbyczf.com/favicon.ico";
      sha256 = "1zd453mwrlc9kafagyvmj9i8vd5a4akp9srbsy9mxa48x77ckqp2";
    };
  };
  icon = "${clash-for-windows-icon.src}[4]";
  desktopItem = makeDesktopItem {
    name = "clash-for-windows";
    desktopName = "Clash for Windows";
    comment = "A Windows/macOS/Linux GUI based on Clash and Electron";
    icon = "clash-for-windows";
    exec = "cfw";
    categories = [ "Network" ];
  };
in
stdenv.mkDerivation rec {
  inherit (clash-for-windows) pname version src;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs =
    [
      gtk3
      pango
      at-spi2-atk
      nss
      libdrm
      alsa-lib
      mesa
    ]
    ++ (with xorg; [
      libXext
      libXcomposite
      libXrandr
      libxshmfence
      libXdamage
    ]);

  runtimeDependencies = [
    libappindicator
    udev
  ];

  installPhase = ''
    mkdir -p "$out/opt"
    cp -r . "$out/opt/clash-for-windows"

    mkdir -p "$out/bin"
    ln -s "$out/opt/clash-for-windows/cfw" "$out/bin/cfw"

    mkdir -p "$out/share/applications"
    install "${desktopItem}/share/applications/"* "$out/share/applications/"

    icon_dir="$out/share/icons/hicolor"
    for s in 16 24 32 48 64 128 256; do
      size="''${s}x''${s}"
      echo "create icon \"$size\""
      mkdir -p "$icon_dir/$size/apps"
      ${imagemagick}/bin/convert -resize "$size" "${icon}" "$icon_dir/$size/apps/clash-for-windows.png"
    done
  '';

  meta = with lib; {
    homepage = "https://github.com/Fndroid/clash_for_windows_pkg";
    description = "A Windows/macOS/Linux GUI based on Clash and Electron";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
