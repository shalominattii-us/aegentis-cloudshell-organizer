#!/bin/bash
# Ω SOVEREIGN ENGINE RESUME — CloudShell Session Recovery
# Run this when reconnecting to CloudShell after timeout

echo "[Ω] Resuming AEGENTIC-Engine..."

SOV_ROOT="/opt/sovereign"
STATE_DIR="$SOV_ROOT/state"
ENGINE_DIR="$SOV_ROOT/engine"

if [ -f "$STATE_DIR/engine.pid" ]; then
    OLD_PID=$(cat "$STATE_DIR/engine.pid")
    if ps -p "$OLD_PID" > /dev/null 2>&1; then
        echo "[ΩΩ] Engine already running (PID: $OLD_PID)"
        echo "[Ω] Last checkpoint: $(cat $SOV_ROOT/.sov_persist | grep Installed)"
        tail -5 "$SOV_ROOT/logs/engine.log"
        exit 0
    fi
fi

# Restart tunnel
echo "[Ω] Re-establishing ROG tunnel..."
nohup bash "$ENGINE_DIR/tunnel.sh" > "$SOV_ROOT/logs/tunnel.log" 2>&1 &
echo $! > "$STATE_DIR/tunnel.pid"

# Restart engine
echo "[Ω] Starting engine..."
nohup python3 "$ENGINE_DIR/engine.py" > "$SOV_ROOT/logs/engine_stdout.log" 2>&1 &
echo $! > "$STATE_DIR/engine.pid"

echo "[ΩΩΩ] Engine resumed. PID: $(cat $STATE_DIR/engine.pid)"
echo "[Ω] tail -f $SOV_ROOT/logs/engine.log"
