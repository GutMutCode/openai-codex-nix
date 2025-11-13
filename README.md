# openai-codex-nix

OpenAI Codex CLI for NixOS and Nix users.

## Quick Start

```nix
# flake.nix
{
  inputs.openai-codex-nix.url = "github:GutMutCode/openai-codex-nix";

  outputs = { openai-codex-nix, ... }: {
    homeConfigurations.user = {
      modules = [
        openai-codex-nix.homeManagerModules.default
      ];
      home.packages = [ pkgs.openai-codex ];
    };
  };
}
```

```bash
# Then rebuild and run
codex --version
```

## Installation Methods

### Method 1: Flake Input (Recommended)

**For home-manager:**
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    openai-codex-nix.url = "github:GutMutCode/openai-codex-nix";
  };

  outputs = { nixpkgs, home-manager, openai-codex-nix, ... }: {
    homeConfigurations."user@hostname" = home-manager.lib.homeManagerConfiguration {
      modules = [
        openai-codex-nix.homeManagerModules.default
        {
          home.packages = [ pkgs.openai-codex ];
        }
      ];
    };
  };
}
```

**For NixOS:**
```nix
{
  inputs.openai-codex-nix.url = "github:GutMutCode/openai-codex-nix";

  outputs = { openai-codex-nix, ... }: {
    nixosConfigurations.hostname = {
      modules = [
        openai-codex-nix.nixosModules.default
        {
          environment.systemPackages = [ pkgs.openai-codex ];
        }
      ];
    };
  };
}
```

### Method 2: Overlay Only

```nix
{
  inputs.openai-codex-nix.url = "github:GutMutCode/openai-codex-nix";

  nixpkgs.overlays = [ openai-codex-nix.overlays.default ];

  home.packages = [ pkgs.openai-codex ];
}
```

### Method 3: Direct Install

```bash
# Temporary shell
nix shell github:GutMutCode/openai-codex-nix

# Install to profile
nix profile install github:GutMutCode/openai-codex-nix

# Run directly
nix run github:GutMutCode/openai-codex-nix
```

## Platform Support

| Platform      | Status | Notes                          |
|---------------|--------|--------------------------------|
| x86_64-linux  | ✅     | Node.js wrapper                |
| aarch64-linux | ✅     | Node.js wrapper                |
| x86_64-darwin | ✅     | Node.js wrapper                |
| aarch64-darwin| ✅     | Node.js wrapper                |

## Requirements

- Node.js (automatically provided)
- No additional requirements

## Usage

```bash
# Start codex
codex

# Check version
codex --version

# Get help
codex --help
```

## Version

Current version: **0.57.0**

This package tracks OpenAI Codex CLI releases from npm registry.

## Development

```bash
# Clone repository
git clone https://github.com/GutMutCode/openai-codex-nix
cd openai-codex-nix

# Test build
nix build

# Test run
nix run . -- --version

# Enter development shell
nix develop
```

## Version Updates

To update to a new version:

1. Check latest version: `npm view @openai/codex version`
2. Update `version` in `package.nix`
3. Get new hash: `nix-prefetch-url --unpack https://registry.npmjs.org/@openai/codex/-/codex-VERSION.tgz`
4. Convert hash: `nix hash to-sri sha256:HASH`
5. Update `hash` in `package.nix`
6. Test: `nix build`

## License

- **This repository (Nix packaging)**: MIT License
- **OpenAI Codex CLI**: Apache-2.0

OpenAI Codex CLI is open source software by OpenAI. This repository only provides Nix packaging.

## Contributing

Contributions welcome! Please:
1. Test on your platform
2. Update version in both package.nix and README
3. Verify hash matches
4. Run `nix flake check`

## Links

- [OpenAI Codex](https://github.com/openai/codex)
- [npm package](https://www.npmjs.com/package/@openai/codex)
- [NixOS Wiki](https://nixos.wiki/)
