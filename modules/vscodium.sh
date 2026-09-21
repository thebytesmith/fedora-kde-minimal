module_vscodium() {
    section "VSCodium"
    local repo=/etc/yum.repos.d/vscodium.repo
    if [[ ! -f "$repo" ]]; then
        sudo tee "$repo" > /dev/null << 'REPO'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
REPO
        ok "VSCodium repo added"
    else
        warn "VSCodium repo already exists — skipping"
    fi
    SETUP_EST_SECS=45 run_bg "VSCodium install" sudo dnf install -y codium
}
