{ nurpkgs, nixgl_, emacs-overlay, ... }:
{
  nixpkgs = {
    overlays = [
      nurpkgs.overlay
      nixgl_.overlay
      emacs-overlay.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
