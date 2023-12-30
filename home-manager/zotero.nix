# Cribbed from: https://valentinpratz.de/posts/2023-11-05-nixos-zotero-beta/
{ pkgs, nixpkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      zotero_beta = prev.zotero.overrideAttrs (old: with prev.zotero; rec {
        pname = "zotero-beta";
        gitRef = "6b996d4f9";
        version = "7.0.0-beta.54";

        libPath = prev.zotero.libPath + ":" + prev.lib.makeLibraryPath [
          prev.alsa-lib
          prev.xorg.libXtst
        ];
        src = pkgs.fetchurl {
          url = "https://download.zotero.org/client/beta/${version}%2B${gitRef}/Zotero-${version}%2B${gitRef}_linux-x86_64.tar.bz2";
          hash = "sha256-U0cSQCY6av1uAndtdJJpMruDBZ/BDtybnbm4ZHvuFmE=";
        };
        meta.knownVulnerabilities = [ ];
        postPatch = "";

        installPhase = ''
          runHook preInstall

          mkdir -p "$prefix/usr/lib/zotero-bin-${gitRef}"
          cp -r * "$prefix/usr/lib/zotero-bin-${gitRef}"
          mkdir -p "$out/bin"
          ln -s "$prefix/usr/lib/zotero-bin-${gitRef}/zotero" "$out/bin/"

          # install desktop file and icons.
          mkdir -p $out/share/applications
          cp ${desktopItem}/share/applications/* $out/share/applications/
          for size in 16 32 48 256; do
            install -Dm444 chrome/icons/default/default$size.png \
              $out/share/icons/hicolor/''${size}x''${size}/apps/zotero.png
          done

          for executable in \
            zotero-bin plugin-container \
            updater minidump-analyzer
          do
            if [ -e "$out/usr/lib/zotero-bin-${gitRef}/$executable" ]; then
              patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
                "$out/usr/lib/zotero-bin-${gitRef}/$executable"
            fi
          done
          find . -executable -type f -exec \
            patchelf --set-rpath "$libPath" \
              "$out/usr/lib/zotero-bin-${gitRef}/{}" \;

          runHook postInstall
        '';
      });
    })
  ];

}
