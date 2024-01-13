{ pkgs, nvidia, ... }:
let
  nixGLWrap = (pkg: pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
    mkdir $out
    ln -s ${pkg}/* $out
    rm $out/bin
    mkdir $out/bin
    for bin in ${pkg}/bin/*; do
     wrapped_bin=$out/bin/$(basename $bin)
     echo "exec ${pkgs.lib.getExe (if nvidia then pkgs.nixgl.auto.nixGLNvidia else pkgs.nixgl.nixGLIntel)} $bin \$@" > $wrapped_bin
     chmod +x $wrapped_bin
    done
  '');
in
{
  nixGLWrap = nixGLWrap;
}
