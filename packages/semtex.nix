# See: https://www.reddit.com/r/NixOS/comments/11nz2fx/how_can_i_install_an_app_image_on_nixos/
{ lib
, fetchurl
, appimageTools
}:
let
  pname = "semtex";
  version = "0.1.2";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/scalar-dev/semtex/releases/download/v${version}/semtex_0.1.0_amd64.AppImage";
    sha256 = "HvPAeQJ8ox0+3U5D7prcnfynuVUH2HUTA7k3s8NXJ3E=";
  };

  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/semtex.desktop $out/share/applications/${pname}.desktop

    install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png

    substituteInPlace $out/share/applications/${pname}.desktop \
    	--replace 'Exec=${pname}' 'Exec=env WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pname} %U'
  '';

  extraPkgs = pkgs: with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  meta = with lib; {
    description = "A friendly cross-platform Installer for Ubuntu Touch.";
    homepage = "https://devices.ubuntu-touch.io/installer";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
