module_flatpak() {
    section "Flatpak & Flathub"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo >> "$LOG_FILE" 2>&1
    local apps=(com.spotify.Client com.discordapp.Discord org.onlyoffice.desktopeditors)
    SETUP_EST_SECS=120 run_bg "Flatpak apps (Spotify, Discord, OnlyOffice)" flatpak install -y flathub "${apps[@]}"
    SETUP_EST_SECS=30 run_bg_soft "SpotX patch" bash -c 'bash <(curl -sSL https://spotx-official.github.io/run.sh)'
}
