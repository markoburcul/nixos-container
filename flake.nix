{
  description = "Testing Codex Service using Nixos containers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    codex-flake.url = "git+https://github.com/codex-storage/nim-codex?ref=add-nix-codex-service-definition&submodules=1#";
  };

  outputs = { self, nixpkgs, codex-flake }: {
    packages.x86_64-linux.codex = codex-flake.packages.x86_64-linux.default;
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({pkgs, ...}: {
          boot.isContainer = true;
          networking.hostName = "codex";

          imports = [ codex-flake.nixosModules.nim-codex ];

          services.nim-codex = {
            enable = true;
            settings = {
              data-dir = "/var/lib/codex-test";
            };
          };
          systemd.services.nim-codex.serviceConfig.StateDirectory = "codex-test";
          system.stateVersion = "24.11";
        })
      ];
    };
  };
}

