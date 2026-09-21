module_fingerprint() {
    section "Fingerprint Sensor"
    run_bg "Enable libfprint COPR" sudo dnf copr enable -y dolmushcu/libfprint-tod
    SETUP_EST_SECS=30 run_bg "Fingerprint packages" sudo dnf install -y libfprint-2-tod1-elan-0c4b fprintd fprintd-pam
    sudo systemctl enable --now fprintd
    ok "fprintd enabled"
}
