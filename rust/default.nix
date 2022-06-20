{ lib
, naersk
, hostPlatform
, targetPlatform
, pkg-config
, libiconv
, rustfmt
, cargo
, rustc
, metadata
}:

naersk.lib."${targetPlatform.system}".buildPackage {
  src = ./.;

  buildInputs = [
    rustfmt
    pkg-config
    cargo
    rustc
    libiconv
  ];
  checkInputs = [ cargo rustc ];

  doCheck = true;
  CARGO_BUILD_INCREMENTAL = "false";
  RUST_BACKTRACE = "full";
  copyLibs = true;

  name = metadata.name;
  version = metadata.version;

  meta = with lib; {
    description = metadata.description;
    homepage = metadata.homepage;
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ ];
  };
}