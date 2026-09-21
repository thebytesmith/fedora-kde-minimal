module_development() {
    section "Development Tools"
    SETUP_EST_SECS=45 run_bg "Development packages" sudo dnf install -y git gh gcc gcc-c++ make curl wget
    ok "Development tools installed"
}
