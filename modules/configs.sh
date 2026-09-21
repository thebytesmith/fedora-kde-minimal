module_configs() {
    section "Configuration & Themes Deployment"

    local user_config="${HOME}/.config"
    local user_local="${HOME}/.local/share"
    local repo_configs="${SCRIPT_DIR}/configs"
    local repo_laf="${SCRIPT_DIR}/look-and-feel"

    log "Deploying application & KDE configurations..."

    # Ensure target directories exist
    mkdir -p "${user_config}"
    mkdir -p "${user_config}/fastfetch"
    mkdir -p "${user_config}/vlc"
    mkdir -p "${user_config}/Code/User"
    mkdir -p "${user_config}/VSCodium/User"

    if [[ -d "$repo_configs" ]]; then
        for item in "$repo_configs"/*; do
            if [[ -f "$item" ]]; then
                cp -f "$item" "${user_config}/"
            fi
        done

        [[ -d "${repo_configs}/fastfetch" ]] && cp -rf "${repo_configs}/fastfetch"/* "${user_config}/fastfetch/"
        [[ -d "${repo_configs}/vlc" ]] && cp -rf "${repo_configs}/vlc"/* "${user_config}/vlc/"
        [[ -d "${repo_configs}/Code" ]] && cp -rf "${repo_configs}/Code"/* "${user_config}/Code/"
        [[ -d "${repo_configs}/VSCodium" ]] && cp -rf "${repo_configs}/VSCodium"/* "${user_config}/VSCodium/"

        ok "Application configurations deployed to ~/.config"
    else
        warn "Configs directory (${repo_configs}) not found"
    fi

    log "Deploying Look and Feel / Plasma themes..."
    mkdir -p "${user_local}/color-schemes"
    mkdir -p "${user_local}/konsole"
    mkdir -p "${user_local}/plasma/look-and-feel"

    if [[ -d "$repo_laf" ]]; then
        [[ -d "${repo_laf}/color-schemes" ]] && cp -rf "${repo_laf}/color-schemes"/* "${user_local}/color-schemes/"
        [[ -d "${repo_laf}/konsole" ]] && cp -rf "${repo_laf}/konsole"/* "${user_local}/konsole/"
        [[ -d "${repo_laf}/plasma/look-and-feel" ]] && cp -rf "${repo_laf}/plasma/look-and-feel"/* "${user_local}/plasma/look-and-feel/"

        ok "Themes, color schemes, and Konsole profiles deployed to ~/.local/share"
    else
        warn "Look-and-feel directory (${repo_laf}) not found"
    fi

    # Adjust paths in deployed files replacing /home/nakul with actual $HOME
    log "Adjusting path references in deployed configs..."
    local search_pattern="/home/nakul"
    local target_home="${HOME}"

    if [[ "$search_pattern" != "$target_home" ]]; then
        find "${user_config}" "${user_local}" -type f \( -name "*.rc" -o -name "*rc" -o -name "*.json" -o -name "*.jsonc" -o -name "*.js" -o -name "*.conf" -o -name "*.colorscheme" -o -name "*.profile" \) -exec sed -i "s|${search_pattern}|${target_home}|g" {} + 2>/dev/null || true
    fi

    # Deploy .bashrc customization if present
    if [[ -f "${SCRIPT_DIR}/.bashrc" ]]; then
        if ! grep -q "PS1=" "${HOME}/.bashrc" 2>/dev/null; then
            cat "${SCRIPT_DIR}/.bashrc" >> "${HOME}/.bashrc"
            ok ".bashrc prompt customization appended"
        else
            ok ".bashrc prompt already customized — skipping"
        fi
    fi

    ok "Configuration & Themes deployment completed"
}
