module_rpmfusion() {
    section "RPM Fusion"
    local fedora_version
    fedora_version="$(rpm -E %fedora)"
    if ! rpm -q rpmfusion-free-release &>/dev/null; then
        SETUP_EST_SECS=20 run_bg "RPM Fusion Free" sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${fedora_version}.noarch.rpm"
        ok "RPM Fusion Free enabled"
    else warn "RPM Fusion Free is already installed — skipping"; fi
    if ! rpm -q rpmfusion-nonfree-release &>/dev/null; then
        SETUP_EST_SECS=20 run_bg "RPM Fusion Nonfree" sudo dnf install -y "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${fedora_version}.noarch.rpm"
        ok "RPM Fusion Nonfree enabled"
    else warn "RPM Fusion Nonfree is already installed — skipping"; fi
    SETUP_EST_SECS=15 run_bg "Refresh DNF metadata" sudo dnf makecache
    ok "RPM Fusion configured"
}
