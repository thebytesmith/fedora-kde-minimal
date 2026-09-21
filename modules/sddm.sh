module_sddm() {
    section "SDDM"
    local wallpaper_src="${SCRIPT_DIR}/assets/sddm.png"
    local wallpaper_dst=/usr/share/wallpapers/custom/sddm.png
    if [[ -f "$wallpaper_src" ]]; then
        sudo mkdir -p /usr/share/wallpapers/custom/
        sudo cp "$wallpaper_src" "$wallpaper_dst"
        ok "SDDM wallpaper copied"
    else warn "Wallpaper '${wallpaper_src}' not found — SDDM background may be missing"; fi
    sudo mkdir -p /usr/share/sddm/themes/breeze
    sudo tee /usr/share/sddm/themes/breeze/theme.conf > /dev/null << EOF
[General]
showlogo=hidden
showClock=true
logo=/usr/share/sddm/themes/breeze/default-logo.svg
type=image
color=#1d99f3
fontSize=10
background=${wallpaper_dst}
needsFullUserModel=false
EOF
    ok "SDDM configured"
}
