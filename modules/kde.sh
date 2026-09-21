module_kde() {
    section "Package Installation"
    local core_plasma=(plasma-desktop konsole dolphin plasma-nm plasma-pa plasma-systemmonitor plasma-firewall firewalld kscreen kwalletmanager kwallet-pam bluedevil powerdevil xdg-desktop-portal-kde kde-gtk-config breeze-gtk cups ffmpegthumbs kf6-baloo-file)
    local essential_plasma=(kwrite kate gwenview spectacle ark unrar tar zip 7zip tree sddm sddm-kcm sddm-breeze bluez kinfocenter okular qrca kde-partitionmanager filelight kcalc)
    local fonts=(google-noto-sans-devanagari-fonts google-noto-color-emoji-fonts rsms-inter-fonts jetbrains-mono-fonts)
    local other=(git gh qbittorrent pdfarranger flatpak flatpak-kcm libreoffice)
    SETUP_EST_SECS=90 run_bg "Core Plasma packages" sudo dnf install -y "${core_plasma[@]}"
    SETUP_EST_SECS=60 run_bg "Essential Plasma apps" sudo dnf install -y "${essential_plasma[@]}"
    SETUP_EST_SECS=30 run_bg "Fonts" sudo dnf install -y "${fonts[@]}"
    SETUP_EST_SECS=30 run_bg "Other packages (git, qbittorrent…)" sudo dnf install -y "${other[@]}"
}
