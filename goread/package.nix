{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "goread";
  version = "1.6.4";

  src = fetchFromGitHub {
    owner = "TypicalAM";
    repo = "goread";
    rev = "v${version}";
    hash = "sha256-m6reRaJNeFhJBUatfPNm66LwTXPdD/gioT8HTv52QOw=";
  };

  vendorHash = "sha256-/kxEnw8l9S7WNMcPh1x7xqiQ3L61DSn6DCIvJlyrip0=";
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/TypicalAM/goread";
    description = "RSS/atom feed reader for the terminal";
    platforms = platforms.linux ++ platforms.darwin;
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ nadir-ishiguro ];
    mainProgram = "goread";
  };
}
