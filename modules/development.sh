module_development() {
    section "Development"
    SETUP_EST_SECS=30 run_bg "Development packages" sudo dnf install -y git gh
}
