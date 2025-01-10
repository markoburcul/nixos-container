# Nixos Container example

## Create container
```nix
nixos-container create codex-test --flake .#container
```

## Run the container
```nix
nixos-container start codex-test 
```

## Check container status
```nix
nixos-container status codex-test                                                                                                                      
up
```

## Exec into container
```nix
nixos-container root-login codex-test
```

