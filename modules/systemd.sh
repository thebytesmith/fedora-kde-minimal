module_systemd() {
    section "Systemd Services"
    sudo systemctl set-default graphical.target
    sudo systemctl enable sddm
    sudo systemctl enable firewalld
    ok "Systemd targets/services configured"
}
