#!/bin/bash

# The directory to check for Git repositories
TARGET_DIR="/home/kunalchand/Desktop/Projects"
TARGET_DIR2="/home/kunalchand/Documents/mint-scripts"

# ANSI color codes
REPO_COLOR='\033[1;33m' # Yellow
FILE_COLOR='\033[0;96m' # Cyan
NO_COLOR='\033[0m'      # No color

# Function to check the git status
check_git_status() {
    local dir=$1
    local repo_name=$(basename "$dir")
    pushd "$dir" > /dev/null

    # Check for unstaged changes
    local unstaged_changes=$(git status --porcelain)
    if [ -n "$unstaged_changes" ]; then
        echo -e "${REPO_COLOR}$repo_name${NO_COLOR} has unstaged changes"
        echo -e "${FILE_COLOR}${unstaged_changes}${NO_COLOR}"
    fi

    # Check for staged but not committed changes
    if ! git diff --cached --quiet; then
        echo -e "${REPO_COLOR}$repo_name${NO_COLOR} has staged changes that are not committed"
        echo -e "${FILE_COLOR}$(git diff --cached --name-only)${NO_COLOR}"
    fi

    # Check for committed but not pushed changes
    local branch=$(git rev-parse --abbrev-ref HEAD)
    if [ -n "$(git log origin/$branch..HEAD)" ]; then
        echo -e "${REPO_COLOR}$repo_name${NO_COLOR} has commits that are not pushed to origin/$branch"
        echo -e "${FILE_COLOR}$(git log origin/$branch..HEAD --oneline)${NO_COLOR}"
    fi

    popd > /dev/null
}

# Function to find all git repositories in the given directory and check their status
find_and_check_git_repos() {
    local root_dir=$1
    for gitdir in $(find "$root_dir" -name ".git" -type d); do
        local repodir=$(dirname "$gitdir")
        check_git_status "$repodir"
    done
}

# Main script execution
find_and_check_git_repos "$TARGET_DIR"
find_and_check_git_repos "$TARGET_DIR2"


