module_cleanup() {
    section "Cleanup"
    for dir in "${HOME}/Public" "${HOME}/Templates"; do
        if [[ -d "$dir" ]]; then rm -rf "$dir"; ok "Removed $dir"; fi
    done
    SETUP_EST_SECS=15 run_bg_soft "Remove plasma-welcome" sudo dnf remove -y plasma-welcome
    local stale_paths=(
        /usr/share/sddm/themes/01-breeze-fedora
        /usr/share/plasma/look-and-feel/org.fedoraproject*
        /usr/share/plasma/look-and-feel/org.kde.breezetwilight.desktop
    )
    local path expanded
    for path in "${stale_paths[@]}"; do
        for expanded in $path; do
            if [[ -e "$expanded" ]]; then sudo rm -rf "$expanded"; ok "Removed $expanded"; fi
        done
    done
    ok "Cleanup complete"
}
