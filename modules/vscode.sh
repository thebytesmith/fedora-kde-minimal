module_vscode() {
    section "Visual Studio Code"

    local repo=/etc/yum.repos.d/vscode.repo

    if [[ ! -f "$repo" ]]; then
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

        sudo tee "$repo" > /dev/null << 'REPO'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
REPO

        ok "VS Code repo added"
    else
        warn "VS Code repo already exists — skipping"
    fi

    SETUP_EST_SECS=45 run_bg "VS Code install" sudo dnf install -y code
}