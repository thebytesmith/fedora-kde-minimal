module_codecs() {
    section "Multimedia Codecs"
    SETUP_EST_SECS=30 run_bg "Replace FFmpeg" sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
    SETUP_EST_SECS=30 run_bg "Install multimedia codecs" sudo dnf group install -y multimedia
    SETUP_EST_SECS=20 run_bg "Install additional codecs" sudo dnf group install -y sound-and-video
    ok "Multimedia codecs configured"
}
