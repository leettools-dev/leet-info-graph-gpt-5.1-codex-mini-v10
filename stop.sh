#!/usr/bin/env bash
set -euo pipefail

PID_DIR="pids"
BACKEND_PID="$PID_DIR/backend.pid"
FRONTEND_PID="$PID_DIR/frontend.pid"

function stop_if_running() {
  local pid_file="$1"
  if [[ -f "$pid_file" ]]; then
    local pid
    pid=$(cat "$pid_file")
    if [[ -n "$pid" ]] && kill -0 "$pid" >/dev/null 2>&1; then
      echo "Stopping process with PID $pid"
      kill "$pid"
      wait "$pid" 2>/dev/null || true
    fi
    rm -f "$pid_file"
  fi
}

stop_if_running "$BACKEND_PID"
stop_if_running "$FRONTEND_PID"
