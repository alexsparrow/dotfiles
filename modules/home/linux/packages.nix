{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Wayland desktop plumbing (used by ./niri.nix binds and ../../../bin scripts)
    bc
    brightnessctl
    cliphist
    grim
    playerctl
    slurp
    upower
    wl-clipboard
    wmctrl
    xwininfo

    # Development
    gdb
    go
    nodejs
    rustup
    strace

    # Terminal apps
    circumflex
    goread
    hledger
    hledger-web
    nom
    toot
    wgnord # NordVPN over WireGuard; run with sudo

    # GUI apps
    calibre
    discord
    evince
    ferdium
    foliate
    gimp
    google-chrome
    karere # WhatsApp client (replaces the removed whatsapp-for-linux)
    kooha
    nomacs
    signal-desktop
    slack
    spotify
    thunar
    xournalpp
    zotero # pinned to the release channel in ../../../overlays

    texliveFull

    wine

    nerd-fonts.droid-sans-mono
  ];
}
