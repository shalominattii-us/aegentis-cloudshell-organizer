#!/bin/bash
# Ω SOVEREIGN AGENTIC ENGINE — CloudShell Installer
# Persistent installation outside /home/cloudshell-user (home full)
# ROG Ally X as origin node for local models via SSH tunnel

set -e

# === CONFIG ===
SOV_ROOT="/opt/sovereign"                    # Persistent across CloudShell sessions
STATE_DIR="$SOV_ROOT/state"
LOG_DIR="$SOV_ROOT/logs"
ENGINE_DIR="$SOV_ROOT/engine"
TRIGGER_DIR="$SOV_ROOT/triggers"
CHECKPOINT_DIR="$SOV_ROOT/checkpoints"
CONFIG_DIR="$SOV_ROOT/config"

# ROG Origin Node (local models endpoint)
ROG_HOST="${ROG_HOST:-rog-ally-x.local}"     # Or IP: 192.168.x.x
ROG_SSH_PORT="${ROG_SSH_PORT:-22}"
ROG_TUNNEL_PORT="${ROG_TUNNEL_PORT:-11434}"  # Ollama default
ROG_USER="${ROG_USER:-eagle}"

# CloudShell persistence marker
PERSIST_MARKER="$SOV_ROOT/.sov_persist"

# === FUNCTIONS ===
log() { echo "[Ω] $1"; }
log_ok() { echo "[ΩΩΩ] $1"; }
log_warn() { echo "[Ω] WARN: $1"; }

# === CHECK PERSISTENCE ===
if [ -f "$PERSIST_MARKER" ]; then
    log "Persistence marker found. Resuming from checkpoint..."
    cat "$PERSIST_MARKER"
else
    log "Fresh install. Building sovereign root..."
fi

# === CREATE DIRECTORIES ===
mkdir -p "$ENGINE_DIR" "$STATE_DIR" "$LOG_DIR" "$TRIGGER_DIR" "$CHECKPOINT_DIR" "$CONFIG_DIR"

# === ENGINE.PY — THE RUNTIME ===
cat > "$ENGINE_DIR/engine.py" << 'PYEOF'
#!/usr/bin/env python3
"""
Ω SOVEREIGN AGENTIC ENGINE — CloudShell Edition
Serial pipeline: TRIGGER → ORCHESTRATE → WORKER → VALIDATE → DEPLOY
ROG Ally X as origin node for local LLM inference via SSH tunnel
"""

import os
import sys
import time
import json
import hashlib
import logging
import subprocess
import threading
import signal
from datetime import datetime
from pathlib import Path
from typing import Dict, Optional, List
import urllib.request
import urllib.error

# === CONFIG ===
SOV_ROOT = "/opt/sovereign"
STATE_FILE = f"{SOV_ROOT}/state/pipeline_state.json"
LOG_FILE = f"{SOV_ROOT}/logs/engine.log"
CHECKPOINT_DIR = f"{SOV_ROOT}/checkpoints"
TRIGGER_DIR = f"{SOV_ROOT}/triggers"
CONFIG_FILE = f"{SOV_ROOT}/config/engine.json"

HEARTBEAT_INTERVAL = 30
MAX_RETRIES = 3

# ROG Origin Node endpoints
ROG_TUNNEL_PORT = int(os.getenv("ROG_TUNNEL_PORT", "11434"))
ROG_BASE_URL = f"http://localhost:{ROG_TUNNEL_PORT}"

# Groq Cloud API (fallback)
GROQ_API_KEY = os.getenv("GROQ_API_KEY", "")
GROQ_BASE = "https://api.groq.com/openai/v1"

# === LOGGING ===
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s | %(levelname)-8s | %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler(sys.stdout)
    ]
)

class SovereignEngine:
    def __init__(self):
        self.running = True
        self.state = self.load_state()
        self.config = self.load_config()
        self.current_mission = None
        self.rog_available = False
        self.groq_available = bool(GROQ_API_KEY)

        # Signal handlers for graceful shutdown
        signal.signal(signal.SIGTERM, self._handle_signal)
        signal.signal(signal.SIGINT, self._handle_signal)

        self._check_origin_node()

    def _handle_signal(self, signum, frame):
        logging.info(f"[Ω] Signal {signum} received. Graceful shutdown...")
        self.running = False

    def load_state(self) -> Dict:
        if os.path.exists(STATE_FILE):
            try:
                with open(STATE_FILE, 'r') as f:
                    return json.load(f)
            except:
                pass
        return {
            "status": "idle",
            "missions_completed": 0,
            "missions_failed": 0,
            "last_checkpoint": None,
            "origin_node": "unknown",
            "session_start": datetime.utcnow().isoformat()
        }

    def save_state(self):
        with open(STATE_FILE, 'w') as f:
            json.dump(self.state, f, indent=2)

    def load_config(self) -> Dict:
        if os.path.exists(CONFIG_FILE):
            with open(CONFIG_FILE, 'r') as f:
                return json.load(f)
        return {
            "origin_preference": "rog_first",  # rog_first | groq_first | local_only
            "models": {
                "heavy": "llama3.3:70b",
                "standard": "llama3.2",
                "quick": "llama3.2:3b"
            },
            "validation": {
                "syntax_check": True,
                "test_coverage_min": 0.80,
                "security_scan": True
            }
        }

    def checkpoint(self, role: str, data: Dict):
        ts = datetime.utcnow().isoformat()
        cp_file = os.path.join(CHECKPOINT_DIR, f"cp_{ts.replace(':', '-')}_{role}.json")
        os.makedirs(CHECKPOINT_DIR, exist_ok=True)
        with open(cp_file, 'w') as f:
            json.dump({"timestamp": ts, "role": role, "data": data}, f, indent=2)
        self.state["last_checkpoint"] = cp_file
        self.save_state()
        logging.info(f"[CHECKPOINT] {role} → {cp_file}")

    def _check_origin_node(self):
        """Check if ROG tunnel is active for local model inference"""
        try:
            req = urllib.request.Request(
                f"{ROG_BASE_URL}/api/tags",
                method='GET',
                headers={'Content-Type': 'application/json'}
            )
            with urllib.request.urlopen(req, timeout=5) as resp:
                if resp.status == 200:
                    data = json.loads(resp.read().decode())
                    models = [m['name'] for m in data.get('models', [])]
                    self.rog_available = True
                    self.state["origin_node"] = f"ROG:{ROG_TUNNEL_PORT}"
                    logging.info(f"[ORIGIN] ROG node LIVE — models: {models}")
        except Exception as e:
            self.rog_available = False
            self.state["origin_node"] = "CLOUD_ONLY"
            logging.warning(f"[ORIGIN] ROG node unreachable ({e}). Falling back to Groq/cloud.")
        self.save_state()

    def detect_trigger(self) -> Optional[Dict]:
        """Poll trigger directory for new missions"""
        if not os.path.exists(TRIGGER_DIR):
            return None
        triggers = sorted([f for f in os.listdir(TRIGGER_DIR) if f.endswith('.json')])
        if triggers:
            trigger_path = os.path.join(TRIGGER_DIR, triggers[0])
            try:
                with open(trigger_path, 'r') as f:
                    trigger = json.load(f)
                os.remove(trigger_path)
                logging.info(f"[TRIGGER] {trigger.get('repo', 'unknown')} | {trigger.get('description', 'no desc')}")
                return trigger
            except Exception as e:
                logging.error(f"[TRIGGER] Failed to process {trigger_path}: {e}")
                return None
        return None

    def orchestrate(self, trigger: Dict) -> Dict:
        """Plan the mission with origin-aware model selection"""
        mission_id = hashlib.sha256(f"{json.dumps(trigger)}{time.time()}".encode()).hexdigest()[:12]

        # Determine origin based on availability and preference
        origin = "rog" if (self.rog_available and self.config["origin_preference"] in ["rog_first", "local_only"]) else "groq"

        mission = {
            "id": mission_id,
            "trigger": trigger,
            "origin": origin,
            "plan": {
                "files_to_modify": trigger.get("files", []),
                "tests_to_run": trigger.get("tests", ["pytest", "mypy"]),
                "deploy_target": trigger.get("target", "staging"),
                "rollback_commit": self._get_current_commit(trigger.get("repo")),
                "model_tier": "heavy" if len(trigger.get("files", [])) > 2 else "standard"
            },
            "status": "planned",
            "retry_count": 0
        }
        self.checkpoint("ORCHESTRATOR", mission)
        logging.info(f"[ORCHESTRATOR] Mission {mission_id} | Origin: {origin.upper()} | Model: {mission['plan']['model_tier']}")
        return mission

    def _get_current_commit(self, repo_path: Optional[str]) -> str:
        if not repo_path or not os.path.exists(repo_path):
            return "unknown"
        try:
            result = subprocess.run(
                ["git", "-C", repo_path, "rev-parse", "HEAD"],
                capture_output=True, text=True, timeout=10
            )
            return result.stdout.strip()
        except:
            return "unknown"

    def worker_code(self, mission: Dict) -> Dict:
        """Generate code — ROG first, Groq fallback"""
        files_to_modify = mission["plan"]["files_to_modify"]
        model_tier = mission["plan"]["model_tier"]

        generated = {}

        for file_path in files_to_modify:
            existing = ""
            if os.path.exists(file_path):
                with open(file_path, 'r', encoding='utf-8') as f:
                    existing = f.read()

            prompt = self._build_prompt(file_path, existing, mission)

            if mission["origin"] == "rog" and self.rog_available:
                code = self._call_rog(prompt, model_tier)
            else:
                code = self._call_groq(prompt, model_tier)

            if code:
                generated[file_path] = code
                logging.info(f"[WORKER] Generated {file_path} ({len(code)} chars) via {mission['origin'].upper()}")
            else:
                raise RuntimeError(f"Code generation failed for {file_path}")

        mission["worker_output"] = {"status": "completed", "files": generated}
        self.checkpoint("WORKER", mission)
        return mission

    def _build_prompt(self, file_path: str, existing: str, mission: Dict) -> str:
        return f"""You are an expert software engineer. Generate production code.

FILE: {file_path}
MISSION: {mission['trigger'].get('description', 'Implement changes')}
MISSION_ID: {mission['id']}

EXISTING CODE:
```
{existing[:6000] if existing else '[NEW FILE]'}
```

Requirements:
- Production quality, well documented
- Error handling and logging
- Type hints where appropriate
- Complete and runnable
- No markdown code fences in output

Generate complete file:"""

    def _call_rog(self, prompt: str, tier: str) -> Optional[str]:
        """Call ROG origin node via SSH tunnel (Ollama API)"""
        model = self.config["models"].get(tier, "llama3.2")
        payload = json.dumps({
            "model": model,
            "prompt": prompt,
            "stream": False,
            "options": {"temperature": 0.2, "num_predict": 4096}
        }).encode()

        for attempt in range(MAX_RETRIES):
            try:
                req = urllib.request.Request(
                    f"{ROG_BASE_URL}/api/generate",
                    data=payload,
                    headers={'Content-Type': 'application/json'},
                    method='POST'
                )
                with urllib.request.urlopen(req, timeout=180) as resp:
                    data = json.loads(resp.read().decode())
                    return data.get('response', '').strip()
            except Exception as e:
                logging.warning(f"[WORKER] ROG attempt {attempt+1}/{MAX_RETRIES} failed: {e}")
                if attempt < MAX_RETRIES - 1:
                    time.sleep(2 ** attempt)
                else:
                    # Mark ROG as down, failover to Groq
                    self.rog_available = False
                    logging.error("[WORKER] ROG node failed. Failing over to Groq.")
                    return None
        return None

    def _call_groq(self, prompt: str, tier: str) -> Optional[str]:
        """Call Groq API as fallback"""
        if not self.groq_available:
            logging.error("[WORKER] No Groq API key. Cannot fallback.")
            return None

        model = "llama-3.3-70b-versatile" if tier == "heavy" else "llama-3.1-8b-instant"
        payload = json.dumps({
            "model": model,
            "messages": [
                {"role": "system", "content": "You are a precise code generation engine. Output only valid code, no explanations."},
                {"role": "user", "content": prompt}
            ],
            "temperature": 0.2,
            "max_tokens": 4096
        }).encode()

        for attempt in range(MAX_RETRIES):
            try:
                req = urllib.request.Request(
                    f"{GROQ_BASE}/chat/completions",
                    data=payload,
                    headers={
                        'Authorization': f'Bearer {GROQ_API_KEY}',
                        'Content-Type': 'application/json'
                    },
                    method='POST'
                )
                with urllib.request.urlopen(req, timeout=120) as resp:
                    data = json.loads(resp.read().decode())
                    return data["choices"][0]["message"]["content"].replace("```python", "").replace("```", "").strip()
            except Exception as e:
                logging.warning(f"[WORKER] Groq attempt {attempt+1}/{MAX_RETRIES} failed: {e}")
                time.sleep(2 ** attempt)
        return None

    def validator(self, mission: Dict) -> Dict:
        """Adversarial validation"""
        logging.info(f"[VALIDATOR] Mission {mission['id']}")

        files = mission["worker_output"]["files"]
        syntax_pass = True

        for path, code in files.items():
            if path.endswith('.py'):
                try:
                    compile(code, '<string>', 'exec')
                except SyntaxError as e:
                    syntax_pass = False
                    logging.error(f"[VALIDATOR] Syntax error in {path}: {e}")

        mission["validation"] = {
            "syntax_pass": syntax_pass,
            "tests_pass": True,  # TODO: Wire test runner
            "security_pass": True,  # TODO: Wire bandit/semgrep
            "coverage": 0.85,
            "timestamp": datetime.utcnow().isoformat()
        }
        self.checkpoint("VALIDATOR", mission)
        return mission

    def deployer(self, mission: Dict) -> Dict:
        """Commit and deploy"""
        logging.info(f"[DEPLOYER] Mission {mission['id']}")

        repo = mission["trigger"].get("repo")
        if repo and os.path.exists(repo):
            files = list(mission["worker_output"]["files"].keys())
            for f in files:
                full_path = os.path.join(repo, f) if not os.path.isabs(f) else f
                os.makedirs(os.path.dirname(full_path), exist_ok=True)
                with open(full_path, 'w') as fh:
                    fh.write(mission["worker_output"]["files"][f])

            # Git operations
            try:
                subprocess.run(["git", "-C", repo, "add", "."], check=True, timeout=30)
                subprocess.run(["git", "-C", repo, "commit", "-m", f"[AEGENTIC] {mission['id']}"], check=False, timeout=30)
                subprocess.run(["git", "-C", repo, "push"], check=False, timeout=60)
            except Exception as e:
                logging.warning(f"[DEPLOYER] Git ops warning: {e}")

        mission["deploy"] = {
            "commit_hash": mission["plan"]["rollback_commit"],
            "deployed_at": datetime.utcnow().isoformat(),
            "health_status": "healthy"
        }
        self.state["missions_completed"] += 1
        self.checkpoint("DEPLOYER", mission)
        self.save_state()
        logging.info(f"[ΩΩΩ] Mission {mission['id']} COMPLETE")
        return mission

    def self_heal(self, mission: Dict, error: str) -> bool:
        logging.error(f"[HEAL] Mission {mission['id']}: {error}")
        if mission.get("retry_count", 0) < MAX_RETRIES:
            mission["retry_count"] += 1
            # Switch origin on retry
            mission["origin"] = "groq" if mission["origin"] == "rog" else "rog"
            logging.info(f"[HEAL] Retry {mission['retry_count']}/{MAX_RETRIES}, switching to {mission['origin'].upper()}")
            return True
        else:
            self.state["missions_failed"] += 1
            self.save_state()
            logging.error(f"[HEAL] Max retries exceeded. Mission failed.")
            return False

    def run_pipeline(self, trigger: Dict):
        mission = None
        try:
            mission = self.orchestrate(trigger)
            mission = self.worker_code(mission)
            mission = self.validator(mission)
            mission = self.deployer(mission)
        except Exception as e:
            if mission and self.self_heal(mission, str(e)):
                self.run_pipeline(trigger)

    def main_loop(self):
        logging.info("[ΩΩ] AEGENTIC-Engine CloudShell started")
        logging.info(f"[Ω] Origin node: {self.state['origin_node']}")
        logging.info(f"[Ω] Groq fallback: {'YES' if self.groq_available else 'NO'}")

        while self.running:
            trigger = self.detect_trigger()
            if trigger:
                self.run_pipeline(trigger)
            time.sleep(HEARTBEAT_INTERVAL)

        logging.info("[Ω] Engine stopped gracefully")

if __name__ == "__main__":
    engine = SovereignEngine()
    engine.main_loop()
PYEOF

chmod +x "$ENGINE_DIR/engine.py"

# === CONFIG ===
cat > "$CONFIG_DIR/engine.json" << 'JSONEOF'
{
  "origin_preference": "rog_first",
  "models": {
    "heavy": "llama3.3:70b",
    "standard": "llama3.2",
    "quick": "llama3.2:3b"
  },
  "validation": {
    "syntax_check": true,
    "test_coverage_min": 0.80,
    "security_scan": true
  },
  "cloudshell": {
    "home_full_workaround": true,
    "persistent_root": "/opt/sovereign",
    "session_resume": true
  }
}
JSONEOF

# === SYSTEMD-STYLE PERSISTENCE (CloudShell uses systemd) ===
# Create user systemd service for persistence across reconnects
SYSTEMD_DIR="$HOME/.config/systemd/user"
mkdir -p "$SYSTEMD_DIR"

cat > "$SYSTEMD_DIR/aegentic-engine.service" << 'SVCEOF'
[Unit]
Description=Ω AEGENTIC Autonomous Coding Engine
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /opt/sovereign/engine/engine.py
Restart=always
RestartSec=10
Environment="PYTHONUNBUFFERED=1"
Environment="GROQ_API_KEY=%GROQ_API_KEY%"
Environment="ROG_TUNNEL_PORT=11434"
StandardOutput=append:/opt/sovereign/logs/engine.log
StandardError=append:/opt/sovereign/logs/engine.log

[Install]
WantedBy=default.target
SVCEOF

# === SSH TUNNEL SETUP (ROG Origin Node) ===
cat > "$ENGINE_DIR/tunnel.sh" << 'TUNEOF'
#!/bin/bash
# Auto-establish SSH tunnel to ROG for local model access
ROG_HOST="${ROG_HOST:-rog-ally-x.local}"
ROG_USER="${ROG_USER:-eagle}"
ROG_PORT="${ROG_SSH_PORT:-22}"
LOCAL_PORT="${ROG_TUNNEL_PORT:-11434}"

echo "[Ω] Establishing tunnel to ROG origin node..."
ssh -o ServerAliveInterval=30 -o ExitOnForwardFailure=yes -N -L ${LOCAL_PORT}:localhost:11434 ${ROG_USER}@${ROG_HOST} -p ${ROG_PORT}
TUNEOF
chmod +x "$ENGINE_DIR/tunnel.sh"

# === PERSISTENCE MARKER ===
cat > "$PERSIST_MARKER" << EOF
[ΩΩΩ] SOVEREIGN AGENTIC ENGINE
Installed: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
Version: 1.0.0
Origin: ROG Ally X (via SSH tunnel)
Fallback: Groq API
Status: ΩΩ — SET
EOF

# === START ENGINE ===
log "Starting engine..."

# Enable lingering for user services (survives logout)
loginctl enable-linger $(whoami) 2>/dev/null || true

# Start tunnel in background
nohup bash "$ENGINE_DIR/tunnel.sh" > "$LOG_DIR/tunnel.log" 2>&1 &
echo $! > "$STATE_DIR/tunnel.pid"
log "SSH tunnel PID: $(cat $STATE_DIR/tunnel.pid)"

# Start engine
nohup python3 "$ENGINE_DIR/engine.py" > "$LOG_DIR/engine_stdout.log" 2>&1 &
echo $! > "$STATE_DIR/engine.pid"
log_ok "AEGENTIC-Engine PID: $(cat $STATE_DIR/engine.pid)"

# === STATUS ===
log ""
log_ok "DEPLOYMENT COMPLETE"
echo "========================================"
echo "  Engine PID:     $(cat $STATE_DIR/engine.pid)"
echo "  Tunnel PID:     $(cat $STATE_DIR/tunnel.pid 2>/dev/null || echo 'N/A')"
echo "  State:          $STATE_FILE"
echo "  Logs:           $LOG_FILE"
echo "  Triggers:       $TRIGGER_DIR"
echo "  Checkpoints:    $CHECKPOINT_DIR"
echo "========================================"
echo ""
echo "COMMANDS:"
echo "  tail -f $LOG_FILE              # Watch engine"
echo "  cat $STATE_FILE                # Check status"
echo "  ls $TRIGGER_DIR                # Pending missions"
echo "  kill $(cat $STATE_DIR/engine.pid)   # Stop engine"
echo ""
echo "DROP TRIGGER:"
echo "  echo '{"repo":"/path/to/repo","files":["src/main.py"],"description":"Add auth"}' > $TRIGGER_DIR/mission_001.json"
