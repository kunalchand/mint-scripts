#!/bin/bash
set -euo pipefail

# ========= CONFIG =========
RESUME_PDF="Kunal_Chand_general.pdf"
RESUME_ZIP="Kunal_Chand_general.zip"
TARGET_NAME="Kunal_Chand_resume.pdf"

PORTFOLIO_DIR="/home/kunalchand/Desktop/Projects/Others/kunalchand.github.io/portfolio/assets"
DESKTOP_DIR="/home/kunalchand/Desktop"

RESUME_REPO="/home/kunalchand/Desktop/Projects/Others/resume-tracker"
PORTFOLIO_REPO="/home/kunalchand/Desktop/Projects/Others/kunalchand.github.io"

DRY_RUN=false

# ========= FUNCTIONS =========
log() {
    echo -e "\n[INFO] $1"
}

error_exit() {
    echo "[ERROR] $1"
    exit 1
}

check_exists() {
    if [ ! -e "$1" ]; then
        error_exit "File or directory not found: $1"
    fi
}

run_cmd() {
    if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] $*"
    else
        eval "$@"
    fi
}

# ========= MAIN =========
# Parse args
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    log "Running in DRY RUN mode (no changes will be made)"
fi

CURRENT_DIR=$(pwd)
VERSION=$(basename "$CURRENT_DIR")

log "Current directory: $CURRENT_DIR"
log "Detected version: $VERSION"

# 1. Extract the zip
check_exists "$RESUME_ZIP"
log "Extracting $RESUME_ZIP..."
run_cmd "unzip -o \"$RESUME_ZIP\""

# 2. Copy the PDF to destinations
check_exists "$RESUME_PDF"

for DEST in "$PORTFOLIO_DIR" "$DESKTOP_DIR"; do
    check_exists "$DEST"
    log "Copying $RESUME_PDF to $DEST/$TARGET_NAME"
    run_cmd "cp -f \"$RESUME_PDF\" \"$DEST/$TARGET_NAME\""
done

# 3. Commit and push in resume-tracker repo
log "Updating resume repo: $RESUME_REPO"
check_exists "$RESUME_REPO"
cd "$RESUME_REPO"
run_cmd "git add ."
run_cmd "git commit -m 'overleaf general $VERSION added' || echo '[INFO] No changes to commit in resume repo'"
run_cmd "git push"

# 4. Commit and push in portfolio repo
log "Updating portfolio repo: $PORTFOLIO_REPO"
check_exists "$PORTFOLIO_REPO"
cd "$PORTFOLIO_REPO"
run_cmd "git add ."
run_cmd "git commit -m 'resume $VERSION added' || echo '[INFO] No changes to commit in portfolio repo'"
run_cmd "git push"

log "✅ Resume update process completed (DRY_RUN=$DRY_RUN)"
