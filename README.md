# Alex's dotfiles

My home directory is managed using [home-manager](https://github.com/nix-community/home-manager) although I'm currently still using Arch Linux.

To setup:

```bash

# Setup nix
sudo pacman -S nix
sudo systemctl start nix-daemon
sudo systemctl enable nix-daemon

sudo groupmod -aU alex nix-users
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf


# Install home-manager
# See: https://nix-community.github.io/home-manager/index.xhtml#ch-installation
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# To configure
git clone git@github.com:alexsparrow/dotfiles.git
cd dotfiles
home-manager switch --flake .

# To update flakes
nix flake update
```
