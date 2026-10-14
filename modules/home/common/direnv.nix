# Pairs with devenv: `echo "use devenv" > .envrc && direnv allow`.
# Shell hooks are wired up automatically for the shells enabled elsewhere.
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
