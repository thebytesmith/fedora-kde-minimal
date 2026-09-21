RED='\033[0;31m';
GREEN='\033[0;32m';
YELLOW='\033[1;33m'
CYAN='\033[0;36m';
BOLD='\033[1m';
DIM='\033[2m';
NC='\033[0m'

log() { echo -e "${CYAN}[INFO]${NC}  $*"; }
ok() { echo -e "${GREEN}[OK]${NC}    $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
err() { echo -e "${RED}[ERROR]${NC} $*" >&2; }
die() { err "$*"; exit 1; }
section() {
    echo -e "\n${CYAN}${BOLD}══════════════════════════════════════════${NC}"
    echo -e "${CYAN}${BOLD}  $*${NC}"
    echo -e "${CYAN}${BOLD}══════════════════════════════════════════${NC}"
}

LOG_FILE="$HOME/fedora-setup-$(date +%Y%m%d-%H%M%S).log"
log "Full output → ${LOG_FILE}"

BAR_WIDTH=30
BAR_FILL="█"
BAR_EMPTY="░"

_draw_bar() {
    local pct=$1 label=$2
    local filled=$(( pct * BAR_WIDTH / 100 ))
    local empty=$(( BAR_WIDTH - filled ))
    local bar=""
    for (( i=0; i<filled; i++ )); do bar+="$BAR_FILL"; done
    for (( i=0; i<empty; i++ )); do bar+="$BAR_EMPTY"; done
    printf "\r  ${CYAN}${bar}${NC} ${DIM}%3d%%${NC}  %s" "$pct" "$label"
}

run_bg() {
    local label="$1"; shift
0    local est_secs="${SETUP_EST_SECS:-30}"
    "$@" >> "$LOG_FILE" 2>&1 &
    local job_pid=$!
    local elapsed=0 pct=0
    while kill -0 "$job_pid" 2>/dev/null; do
        pct=$(( elapsed * 95 / est_secs ))
        (( pct > 95 )) && pct=95
        _draw_bar "$pct" "$label"
        sleep 0.15
        (( elapsed++ )) || true
    done
    wait "$job_pid"
    local status=$?
    if (( status == 0 )); then
        _draw_bar 100 "$label"
        echo -e "  ${GREEN}✓${NC}"
    else
        _draw_bar "$pct" "$label"
        echo -e "  ${RED}✗  (exit $status — see $LOG_FILE)${NC}"
        return "$status"
    fi
}

run_bg_soft() {
    local label="$1"; shift
    run_bg "$label" "$@" || warn "Non-fatal failure: $label"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SUDO_KEEPALIVE_PID=""

preflight_checks() {
    [[ -f /etc/fedora-release ]] || die "This script is intended for Fedora only."
    sudo -v || die "This script requires sudo privileges."
    ( while true; do sudo -v; sleep 50; done ) &
    SUDO_KEEPALIVE_PID=$!
    trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null' EXIT
}
