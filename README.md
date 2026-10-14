# Alex's dotfiles

One flake for two platforms:

- **NixOS** — standalone [home-manager](https://github.com/nix-community/home-manager).
  The system configuration itself (drivers, greetd, `programs.niri`) lives in
  `/etc/nixos` and is not managed here.
- **macOS** — [nix-darwin](https://github.com/nix-darwin/nix-darwin), with
  home-manager wired in as a system module.

## Layout

```
flake.nix               inputs + the mkHome / mkDarwin helpers
hosts/                  per-machine configuration
  fw.nix                  Framework laptop        (homeConfigurations.alex-fw)
  nuc.nix                 desktop, NVIDIA         (homeConfigurations.alex-nuc)
  macbook-pro.nix         MacBook Pro             (darwinConfigurations."Alexs-MacBook-Pro")
modules/
  home/common/          home-manager, both platforms (zsh, git, emacs, vscode)
  home/linux/           niri, firefox, dunst, alacritty, desktop packages
  home/darwin/          mac-only home-manager bits
  darwin/               nix-darwin system config (homebrew, java)
overlays/               nixpkgs overlays (NUR, emacs-overlay)
bin/                    scripts, linked to ~/.bin
wallpaper/              linked to ~/.local/share/wallpaper
docs/macos.md           one-off macOS setup notes
```

## Usage

NixOS. The system config needs
`nix.settings.experimental-features = [ "nix-command" "flakes" ]` first; the
home-manager CLI is not needed to bootstrap and comes from home-manager itself
afterwards:

```bash
# first time on a machine
nix run home-manager/master -- switch -b backup --flake ~/dotfiles#alex-nuc

# thereafter
home-manager switch -b backup --flake ~/dotfiles#alex-nuc
# or, aliased: hmup
```

Host configurations are named after the hostname (`alex-nuc`, `alex-fw`), which
is what the `hmup` alias relies on. `-b backup` matters on a machine that still
has unmanaged dotfiles — home-manager refuses to clobber e.g. an existing
`~/.config/niri/config.kdl`.

macOS:

```bash
# bootstrap
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/dotfiles

# thereafter
sudo darwin-rebuild switch --flake ~/dotfiles
# or, aliased: darwinup
```

Updating inputs:

```bash
nix flake update
nix fmt -- $(git ls-files '*.nix')   # or just let pre-commit do it
```

## Notes

- The compositor is [niri](https://github.com/YaLTeR/niri); its config is
  `modules/home/linux/niri/config.kdl`. The hyprland modules are still in
  `modules/home/linux/` but aren't imported — import `./hyprland.nix` from a
  host to get them back.
- `/etc/nixos` deliberately keeps only what has to be system-wide:
  `programs.niri`, greetd, drivers, and `vim`/`wget` so a broken home-manager
  generation is still repairable. User-facing apps (ghostty, noctalia-shell,
  firefox, claude-code) are installed from here.
- noctalia's own settings (`~/.config/noctalia/*.json`) are written by the shell
  at runtime, so they're left unmanaged.
