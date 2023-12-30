{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # NOTE: Using code-insiders due to https://github.com/microsoft/vscode/issues/184124
    # vscode
    ((vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
      src = (builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
        sha256 = "017630xgr64qjva73imb56fcqr858xfcsbdgq97akawlxf1ydm5a";
      });
      version = "latest";

      buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
    }))
  ];
}
