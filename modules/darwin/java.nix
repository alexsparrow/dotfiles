# macOS tooling expects JDKs under /Library/Java/JavaVirtualMachines, so symlink
# the nix-provided ones into place and default JAVA_HOME to 17.
{ pkgs, ... }:
let
  javaHome = "/Library/Java/JavaVirtualMachines/17.jdk";
in
{
  environment.systemPackages = with pkgs; [
    jdk17
    jdk25
  ];

  system.activationScripts.extraActivation.text = ''
    ln -sf "${pkgs.jdk25}" "/Library/Java/JavaVirtualMachines/25.jdk"
    ln -sf "${pkgs.jdk17}" "/Library/Java/JavaVirtualMachines/17.jdk"
  '';

  launchd.user.envVariables.JAVA_HOME = javaHome;

  programs.zsh.variables.JAVA_HOME = javaHome;
}
