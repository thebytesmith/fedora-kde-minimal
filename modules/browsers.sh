module_browsers() {
    section "Browsers"
    if command -v brave-browser &>/dev/null; then
        warn "Brave is already installed — skipping"
    else
        SETUP_EST_SECS=45 run_bg "Brave Browser install" bash -c 'curl -fsS https://dl.brave.com/install.sh | FLAVOR=origin sh'
    fi
}
