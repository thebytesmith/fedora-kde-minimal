# Module selection UI
declare -a SELECTED_MODULES=()

MODULE_KEYS=(
    system rpmfusion codecs kde systemd vscodium development browsers flatpak fingerprint sddm cleanup
)

MODULE_LABELS=(
    "System / DNF"
    "RPM Fusion"
    "Multimedia codecs"
    "KDE Plasma & applications"
    "Systemd services"
    "VSCodium"
    "Development tools"
    "Browsers"
    "Flatpak apps"
    "Fingerprint sensor"
    "SDDM customization"
    "Cleanup"
)

choose_modules() {
    section "Fedora KDE Setup"
    echo "Choose modules to run."
    echo
    echo "  1) Minimal KDE"
    echo "  2) Full setup (original script)"
    echo "  3) Custom selection"
    echo
    read -rp "Select [1-3]: " choice

    case "$choice" in
        1) SELECTED_MODULES=(system rpmfusion kde systemd) ;;
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
        (( i >= 1 && i <= ${#MODULE_KEYS[@]} )) || die "Invalid module: $i"
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
