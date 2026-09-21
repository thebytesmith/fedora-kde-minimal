# Module selection UI
declare -a SELECTED_MODULES=()

MODULE_KEYS=(
    system
    rpmfusion
    codecs
    kde
    systemd
    vscode
    vscodium
    development
    browsers
    flatpak
    fingerprint
    sddm
    configs
    cleanup
)

MODULE_LABELS=(
    "System / DNF parallel downloads & update"
    "RPM Fusion repositories (Free & Nonfree)"
    "Multimedia codecs (FFmpeg & GStreamer)"
    "KDE Plasma desktop & essential apps"
    "Systemd services & default graphical target"
    "Visual Studio Code (Microsoft repo)"
    "VSCodium (Open-source binary release)"
    "Development tools (Git, GitHub CLI)"
    "Browsers (Brave Browser)"
    "Flatpak apps (Spotify, Discord, OnlyOffice)"
    "Fingerprint sensor (fprintd / ELAN COPR)"
    "SDDM display manager customization"
    "Configurations & Plasma theme deployment"
    "Cleanup (unwanted home folders & plasma-welcome)"
)

choose_modules() {
    section "Fedora KDE Setup"
    echo "Choose setup profile:"
    echo
    echo "  1) Minimal KDE (System, RPM Fusion, Codecs, KDE, Systemd, SDDM, Configs, Cleanup)"
    echo "  2) Full Setup (All available modules)"
    echo "  3) Custom Selection"
    echo
    read -rp "Select [1-3]: " choice

    case "$choice" in
        1) SELECTED_MODULES=(system rpmfusion codecs kde systemd sddm configs cleanup) ;;
        2) SELECTED_MODULES=("${MODULE_KEYS[@]}") ;;
        3) custom_selection ;;
        *) die "Invalid selection" ;;
    esac
}

custom_selection() {
    local i input
    SELECTED_MODULES=()
    echo
    for i in "${!MODULE_KEYS[@]}"; do
        printf "  %2d) %s\n" "$((i+1))" "${MODULE_LABELS[$i]}"
    done
    echo
    read -rp "Enter numbers separated by spaces (e.g. 1 2 4 5): " input
    for i in $input; do
        [[ "$i" =~ ^[0-9]+$ ]] || die "Invalid module: $i"
        (( i >= 1 && i <= ${#MODULE_KEYS[@]} )) || die "Invalid module index: $i"
        SELECTED_MODULES+=("${MODULE_KEYS[$((i-1))]}")
    done
    ((${#SELECTED_MODULES[@]})) || die "No modules selected."
}

run_selected_modules() {
    local module
    for module in "${SELECTED_MODULES[@]}"; do
        "module_${module}"
    done
}
