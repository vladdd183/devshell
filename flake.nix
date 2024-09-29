{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    # nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    cachix = {
    url = "github:cachix/cachix";
    inputs = {
      nixpkgs.follows = "nixpkgs";
    };
    };
  };

  nixConfig = {
    extra-trusted-public-keys = ["devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "vladdd183.cachix.org-1:/bHpXiU15hyjgjNO6wfvEp3U9ds3N+JwYgrCTPfecgs="];
    extra-substituters = ["https://devenv.cachix.org" "https://nix-community.cachix.org" "https://vladdd183.cachix.org"];
  };

  outputs = inputs@{ self, flake-parts, ... }: 
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        # packages.default = pkgs.hello;

        devenv.shells.default = {
          # devenv.root =
          #   let
          #     devenvRootFileContent = builtins.readFile devenv-root.outPath;
          #   in
          #   pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;
          # languages.python.uv.enable = true;
          # languages.python.uv.sync.enable = true;

          name = "my-project";

          imports = [
            # This is just like the imports in devenv.nix.
            # See https://devenv.sh/guides/using-with-flake-parts/#import-a-devenv-module
            # ./devenv-foo.nix
          ];

          # https://devenv.sh/reference/options/
          packages = [ pkgs.cowsay pkgs.xonsh pkgs.zellij pkgs.python313 pkgs.uv];
          enterShell = ''
export XONSHRC="${self}/configs/xonsh/xonshrc"
export XDG_CONFIG_HOME="${self}/configs/neovim"
export ZELLIJ_CONFIG="${self}/configs/zellij/config.yaml"
${pkgs.bash}/bin/bash --login -c '${self}/scripts/entry-shell.sh'
            '';

          # processes.hello.exec = "hello";
        };

      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
