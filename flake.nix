{
  description = "Единое окружение разработки с xonsh, Neovim и Zellij с использованием flake-parts и devenv";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05"; # Выберите подходящую версию
    devenv.url = "github:cachix/devenv";
    # Добавьте другие входы при необходимости
  };

  outputs = { self, flake-parts, nixpkgs, devenv, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        devenv.flakeModule
      ];

      systems = flake-parts.lib.systems.supported;

      perSystem = { config, self', inputs', pkgs, system, ... }: let
        # Сокращаем ссылки на пакеты
        inherit pkgs;
        myPackages = with pkgs; [
          xonsh
          neovim
          zellij
          # Добавьте другие необходимые пакеты
        ];
      in {
        devShells.default = pkgs.devenv.mkShell {
          name = "development-shell";
          buildInputs = myPackages;

          # Настройка окружения
          shellHook = ''
            export XONSHRC="${self.path}/configs/xonsh/xonshrc"
            export XDG_CONFIG_HOME="${self.path}/configs/neovim"
            export ZELLIJ_CONFIG="${self.path}/configs/zellij/config.yaml"
          '';

          # Автоматический запуск xonsh при входе
          shell = "${pkgs.bash}/bin/bash --login -c '${self.path}/scripts/entry-shell.sh'";
        };
      };
    };
}

