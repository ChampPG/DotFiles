{ stdenv }:
let
  user = "ppg";
in 
{
  stdenv.mkDerivation rec {
    pname = "catppuccin-mocha-sddm";
    version = "1";
    dontBuild = true;
    src = "/home/${user}/DotFiles/NixOS/catppuccin-mocha-sddm";
    installPhase = ''
      mkdir -p /run/current-system/sw/share/sddm/themes
      cp -aR $src /run/current-system/sw/share/sddm/themes/catppuccin-mocha-sddm
    '';

  };
}
