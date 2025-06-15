{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    xylo-source = { url = "github:giraffekey/xylo/v0.1.2"; flake = false; };
  };

  outputs = { self, nixpkgs, flake-utils, xylo-source, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        with import nixpkgs { inherit system; };
        let
          xylo-lang = rustPlatform.buildRustPackage {
            pname = "xylo";
            version = xylo-source.rev;
            src = xylo-source;
            cargoHash = "sha256-bqs86sYUzfTI9Cj4k/KHcg8MSwk5v4FwqDzw7Q+hkRM=";
          };
        in
        {
          devShells.default = mkShell {
            buildInputs = [
              just
              xylo-lang
              nodemon
            ];

            # RUST_BACKTRACE = 1;
            # LIBCLANG_PATH = "${libclang.lib}/lib";
            # LD_LIBRARY_PATH = "${lib.makeLibraryPath (buildInputs ++ nativeBuildInputs)}";
          };
        });
}

# fetchFromGitHub { owner = "giraffekey"; repo = "xylo"; rev = "v0.1.2"; sha256 = "sha256-CeWedz3xAnIeHP80WkZC/Ts7qVo68CPsjjeyacBgvSU="; }
