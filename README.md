# Fedora KDE Minimal Setup

Automated post-installation framework and dotfile setup script to transform a minimal Fedora installation (e.g., Fedora Everything / Netinstall TTY) into a fast, clean, and fully configured KDE Plasma desktop environment.

---

## Features

- **Modular Execution**: Choose between pre-defined profiles (*Minimal KDE*, *Full Setup*) or interactively pick individual modules.
- **Visual Terminal UI**: Real-time progress bars, detailed status messages, and log output saved to `~/fedora-setup-*.log`.
- **Performance Tweaks**: Configures `max_parallel_downloads=10` in DNF for faster package updates and installs.
- **Repository Management**: Enables RPM Fusion Free & Nonfree repositories along with Flathub.
- **Multimedia Codecs**: Swaps `ffmpeg-free` to full `ffmpeg` and installs essential multimedia codec groups.
- **Curated KDE Plasma Desktop**: Installs core Plasma desktop packages, KDE apps (Dolphin, Spectacle, Kate, Gwenview, Ark), and essential fonts.
- **Development Tools**: Installs Git, GitHub CLI (`gh`), GCC, Make, Curl, Wget, JQ, and optional editors (VS Code / VSCodium).
- **Custom SDDM Theme**: Automatically applies a styled SDDM login screen with custom wallpaper.
- **Plasma Look & Feel**: Deploys "Light Meets Darkness" theme, custom color schemes, and Konsole terminal profiles.
- **Application Dotfiles**: Restores pre-configured dotfiles for Dolphin, Fastfetch, Spectacle, Kate, KWrite, VLC, VS Code, VSCodium, and custom Bash prompt.
- **Hardware Integration**: Optional driver setup for ELAN fingerprint sensors (`fprintd`).
- **Post-Setup Cleanup**: Removes unnecessary home folders (`~/Public`, `~/Templates`) and disables `plasma-welcome`.

---

## Requirements

- **Operating System**: Fedora Linux (Fresh installation recommended, e.g., Fedora Everything / Server / Minimal TTY).
- **Privileges**: User account with `sudo` permissions.
- **Utilities**: `git` installed (`sudo dnf install -y git`).

---

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/TheByteSmith/fedora-kde-minimal.git
   cd fedora-kde-minimal
   ```

2. Make the setup script executable:
   ```bash
   chmod +x setup.sh
   ```

3. Run the installer:
   ```bash
   ./setup.sh
   ```

4. Follow the interactive menu to select your installation profile and reboot your system once complete:
   ```bash
   sudo reboot
   ```

---

## Setup Profiles & Modules

| Module Key | Description | Included in Minimal Profile |
| :--- | :--- | :---: |
| `system` | Configures DNF parallel downloads & updates system packages | Yes |
| `rpmfusion` | Enables RPM Fusion Free & Nonfree repositories | Yes |
| `codecs` | Replaces `ffmpeg-free` with `ffmpeg` and installs multimedia codecs | Yes |
| `kde` | Installs core KDE Plasma desktop, system tools, and essential fonts | Yes |
| `systemd` | Sets graphical target and enables `sddm` & `firewalld` services | Yes |
| `sddm` | Applies custom SDDM background wallpaper and theme configs | Yes |
| `configs` | Deploys Plasma themes, color schemes, Konsole profiles & app dotfiles | Yes |
| `cleanup` | Removes empty default folders (`Public`, `Templates`) & `plasma-welcome` | Yes |
| `vscode` | Installs official Microsoft Visual Studio Code | No (Full / Custom) |
| `vscodium` | Installs telemetry-free VSCodium binary releases | No (Full / Custom) |
| `development` | Installs development utilities (`git`, `gh`, `gcc`, `make`, `jq`) | No (Full / Custom) |
| `browsers` | Installs Brave Browser | No (Full / Custom) |
| `flatpak` | Enables Flathub and installs Spotify, Discord, & OnlyOffice | No (Full / Custom) |
| `fingerprint` | Enables COPR for ELAN fingerprint sensors and configures `fprintd` | No (Full / Custom) |

---

## Repository Layout

```text
.
├── assets/
│   └── sddm.png                    # SDDM custom background wallpaper
├── configs/                        # Application configuration files (~/.config)
│   ├── Code/User/                  # VS Code settings
│   ├── fastfetch/                  # Fastfetch system info layout
│   ├── vlc/                        # VLC media player preferences
│   ├── VSCodium/User/              # VSCodium settings
│   ├── dolphinrc                   # Dolphin file manager settings
│   ├── kdeglobals                  # Global KDE environment configs
│   ├── konsolerc                   # Konsole application configs
│   └── ...                         # Other KDE app configs (kate, spectacle, etc.)
├── lib/
│   ├── core.sh                     # Logging, progress bar, and preflight validation
│   └── ui.sh                       # Interactive menu UI and module execution runner
├── look-and-feel/                  # Plasma look-and-feel themes & color schemes (~/.local/share)
│   ├── color-schemes/              # Custom Plasma color schemes
│   ├── konsole/                    # Konsole color schemes and profiles
│   └── plasma/look-and-feel/       # Plasma "Light Meets Darkness" desktop layout
├── modules/                        # Modular bash scripts for individual setup steps
│   ├── browsers.sh
│   ├── cleanup.sh
│   ├── codecs.sh
│   ├── configs.sh
│   ├── development.sh
│   ├── fingerprint.sh
│   ├── flatpak.sh
│   ├── kde.sh
│   ├── rpmfusion.sh
│   ├── sddm.sh
│   ├── system.sh
│   ├── systemd.sh
│   ├── vscode.sh
│   └── vscodium.sh
├── .bashrc                         # Custom terminal prompt PS1 configuration
├── README.md                       # Documentation
└── setup.sh                        # Main execution entrypoint script
```

---

## Customization

- **Custom Configurations**: To modify desktop preferences or app settings before running the script, edit the files inside `configs/` or `look-and-feel/`.
- **Wallpapers**: Replace `assets/sddm.png` with your preferred image to customize the login screen background.

---

## Troubleshooting & Logs

Every execution generates a timestamped log file in your home directory:
```text
~/fedora-setup-YYYYMMDD-HHMMSS.log
```
If any module fails, inspect the log for exact error messages:
```bash
cat ~/fedora-setup-*.log
```

---

## License

Distributed under the [MIT License](LICENSE).
