#!/bin/bash
# Claude Code Status Line
# Shows: [Model] dir | git branch | context bar | cost | duration

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
VIM_MODE=$(echo "$input" | jq -r '.vim.mode // ""')

# ANSI colors
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
BLUE='\033[34m'
DIM='\033[2m'
RESET='\033[0m'

# Context bar color by usage
if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

# Build progress bar (10 chars)
FILLED=$((PCT / 10))
EMPTY=$((10 - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '█')
[ "$EMPTY" -gt 0 ] && BAR="${BAR}$(printf "%${EMPTY}s" | tr ' ' '░')"

# Duration format
MINS=$((DURATION_MS / 60000))
SECS=$(((DURATION_MS % 60000) / 1000))
COST_FMT=$(printf '$%.3f' "$COST")

# Git info
BRANCH=""
GIT_STATUS=""
if git -C "${DIR}" rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git -C "${DIR}" branch --show-current 2>/dev/null)
    STAGED=$(git -C "${DIR}" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED=$(git -C "${DIR}" diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    GIT_PART=" | 🌿 ${BRANCH}"
    [ "$STAGED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${GREEN}+${STAGED}${RESET}"
    [ "$MODIFIED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${YELLOW}~${MODIFIED}${RESET}"
    [ -n "$GIT_STATUS" ] && GIT_PART="${GIT_PART} ${GIT_STATUS}"
fi

# Vim mode indicator
VIM_INDICATOR=""
[ -n "$VIM_MODE" ] && VIM_INDICATOR=" ${DIM}[${VIM_MODE}]${RESET}"

# Line 1: model | dir | git
echo -e "${CYAN}[${MODEL}]${RESET} 📁 ${DIR##*/}${GIT_PART}${VIM_INDICATOR}"
# Line 2: context bar | cost | time
echo -e "${BAR_COLOR}${BAR}${RESET} ${PCT}% ctx | ${YELLOW}${COST_FMT}${RESET} | ⏱ ${MINS}m${SECS}s"
