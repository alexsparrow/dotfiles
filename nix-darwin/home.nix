{ config, pkgs, inputs, lib, ... }:

{

  imports = [
    ../home-manager/emacs.nix
    inputs.android-nixpkgs.hmModule
  ];

  android-sdk = {
    enable = true;

    # Optional: path where the SDK will be symlinked
    path = "${config.home.homeDirectory}/.android/sdk";

    # Select the specific packages you need
    packages = sdkPkgs: with sdkPkgs; [
      build-tools-34-0-0
      build-tools-35-0-0
      build-tools-36-1-0
      cmdline-tools-latest
      emulator
      platforms-android-31
      platforms-android-34
      platforms-android-35
      platforms-android-36
      platform-tools
      sources-android-31
      sources-android-34
      sources-android-35
      sources-android-36
      ndk-27-0-12077973
      cmake-3-22-1
    ];
  };

  home = {
    packages = with pkgs; [
      (writeShellScriptBin "claude-profile" (builtins.readFile ./scripts/claude-profile))
      cfr
      llm
      glow
      kubectl
      postgresql
      nixfmt-rfc-style
      cargo
      rustc
      wasm-pack
      llvmPackages.bintools

      aerospace
      spotify
      discord
      slack
      iterm2
      python313
      nodejs_24
      bun
      flutter
      zed-editor
      betterdisplay
      wget
      pnpm
    ];
  };

  programs.starship.enable = true;
  programs.vscode = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      _claude_profile() { compadd $(claude-profile --complete) }
      compdef _claude_profile claude-profile
    '';
  };

  programs.direnv = {
      enable = true;
      nix-direnv.enable = true; # Highly recommended for performance
  };

  home.sessionVariables = {
    # Path to the specific NDK version you installed
    ANDROID_NDK_ROOT = "${config.home.homeDirectory}/.android/sdk/ndk/27.0.12077973";

    # Some older tools look for this instead
    ANDROID_NDK_HOME = "${config.home.homeDirectory}/.android/sdk/ndk/27.0.12077973";

    CLAUDE_CONFIG_DIR = "$(claude-profile --dir)";
  };

  # ... other configurations like programs, packages, etc.
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
