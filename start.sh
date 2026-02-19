#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="logs"
PID_DIR="pids"
BACKEND_LOG="$LOG_DIR/backend.log"
FRONTEND_LOG="$LOG_DIR/frontend.log"
BACKEND_PID="$PID_DIR/backend.pid"
FRONTEND_PID="$PID_DIR/frontend.pid"

mkdir -p "$LOG_DIR" "$PID_DIR"

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

# Stop old processes
stop_if_running "$BACKEND_PID"
stop_if_running "$FRONTEND_PID"

# Start backend (placeholder)
python -m http.server 8000 >"$BACKEND_LOG" 2>&1 &
echo "$!" >"$BACKEND_PID"

# Start frontend (placeholder)
python -m http.server 3000 >"$FRONTEND_LOG" 2>&1 &
echo "$!" >"$FRONTEND_PID"

sleep 1

FRONTEND_URL="http://localhost:3000"
API_URL="http://localhost:8000"

echo "Frontend ready at $FRONTEND_URL"
echo "API ready at $API_URL"
