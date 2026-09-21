module_system() {
    section "DNF Configuration & System Update"
    local dnf_conf=/etc/dnf/dnf.conf
    if ! grep -q "^max_parallel_downloads" "$dnf_conf" 2>/dev/null; then
        echo 'max_parallel_downloads=10' | sudo tee -a "$dnf_conf" > /dev/null
        ok "Set max_parallel_downloads=10"
    else
        warn "max_parallel_downloads already configured — skipping"
    fi
    SETUP_EST_SECS=120 run_bg "System update" sudo dnf update -y
}
