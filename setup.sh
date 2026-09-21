#!/usr/bin/env bash
# Fedora KDE Plasma Setup
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/core.sh"
source "$SCRIPT_DIR/lib/ui.sh"
source "$SCRIPT_DIR/modules/system.sh"
source "$SCRIPT_DIR/modules/rpmfusion.sh"
source "$SCRIPT_DIR/modules/codecs.sh"
source "$SCRIPT_DIR/modules/kde.sh"
source "$SCRIPT_DIR/modules/systemd.sh"
source "$SCRIPT_DIR/modules/vscode.sh"
source "$SCRIPT_DIR/modules/vscodium.sh"
source "$SCRIPT_DIR/modules/development.sh"
source "$SCRIPT_DIR/modules/browsers.sh"
source "$SCRIPT_DIR/modules/flatpak.sh"
source "$SCRIPT_DIR/modules/fingerprint.sh"
source "$SCRIPT_DIR/modules/sddm.sh"
source "$SCRIPT_DIR/modules/configs.sh"
source "$SCRIPT_DIR/modules/cleanup.sh"

main() {
    preflight_checks
    choose_modules
    run_selected_modules
    section "Setup Complete"
    echo -e "${GREEN}${BOLD}All selected steps finished. Full log: ${LOG_FILE}${NC}"
    echo -e "${YELLOW}A reboot is recommended.${NC}"
}
main "$@"
