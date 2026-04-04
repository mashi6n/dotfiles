<h1 align="center">𝙳𝚘𝚝𝚏𝚒𝚕𝚎𝚜</h1>

### Platforms
- macos (`aarch64`)
- linux (`aarch64`, `x86_64`)

### Requirements
- [Nix](https://github.com/NixOS/nix)
  ```bash
  curl -fsSL https://install.determinate.systems/nix | sh -s -- install
  ```

### Customization
1. Add your machine's `system`, `username`, and `homeDirectory` to the `hosts` attrset in `flake.nix`.
2. Extend the `HOST` resolution logic in `install.sh` and `uninstall.sh` to include a branch for the newly added host.

### Install
```bash
./install.sh
```

### Uninstall
```bash
./uninstall.sh
```

