{ inputs }:
[
  # Firefox add-ons (nur.repos.rycee.firefox-addons)
  inputs.nur.overlays.default
  # Bleeding-edge emacs, used by modules/home/common/emacs.nix
  inputs.emacs-overlay.overlays.default
  # Packages taken from the release channel rather than unstable.
  (_final: prev: {
    # Broken on unstable, see NixOS/nixpkgs#568692.
    inherit (inputs.nixpkgs-stable.legacyPackages.${prev.stdenv.hostPlatform.system}) zotero;
  })
]
