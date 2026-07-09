# ============================================================
# AEGENTIS Windows Profile Organizer
# Organizes C:\Users\eagle into C:\Users\eagle\organized\
# Safe: moves only, never deletes. Generates indexes.
# ============================================================
param()

$ErrorActionPreference = "SilentlyContinue"
$Host.UI.RawUI.WindowTitle = "AEGENTIS ORGANIZER"

Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "  ║   AEGENTIS WINDOWS PROFILE ORGANIZER              ║" -ForegroundColor Cyan
Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$homeDir = "$env:USERPROFILE"
$organizedDir = "$homeDir\organized"
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupDir = "$homeDir\organized_bak_$timestamp"

# Create backup listing
Write-Host "  [.] Creating backup listing..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
Get-ChildItem -Path $homeDir -Force | Format-Table -AutoSize | Out-File -FilePath "$backupDir\listing_before.txt"

# Create directory structure
Write-Host "  [.] Creating organized directory structure..." -ForegroundColor Yellow
$folders = @(
    "$organizedDir\core",
    "$organizedDir\agents",
    "$organizedDir\mcp",
    "$organizedDir\infrastructure\terraform",
    "$organizedDir\infrastructure\scripts",
    "$organizedDir\containers",
    "$organizedDir\security",
    "$organizedDir\financial",
    "$organizedDir\legal",
    "$organizedDir\orchestrators",
    "$organizedDir\lambdas",
    "$organizedDir\logs",
    "$organizedDir\archives",
    "$organizedDir\ledger",
    "$organizedDir\runtime",
    "$organizedDir\osint",
    "$organizedDir\configs",
    "$organizedDir\dev\android",
    "$organizedDir\dev\node",
    "$organizedDir\dev\python",
    "$organizedDir\dev\dotnet",
    "$organizedDir\dev\unity",
    "$organizedDir\projects",
    "$organizedDir\trash"
)
foreach ($f in $folders) { New-Item -ItemType Directory -Path $f -Force | Out-Null }

# Move function
function Move-ItemSafe($source, $dest) {
    $srcPath = Join-Path $homeDir $source
    if (Test-Path $srcPath) {
        Move-Item -Path $srcPath -Destination $dest -Force -ErrorAction SilentlyContinue
    }
}

# ============================================================
# CORE AEGENTIS / SOVEREIGN SYSTEMS
# ============================================================
Write-Host "  [.] Sorting core systems..." -ForegroundColor Yellow
$coreItems = @(
    "AEGENTIS", "aegentis-x", "aegentis_runtime", "aegentis-console",
    "aegentis-auditor", "aegentis-skill-registry-fixed", ".aegentis",
    "AEGENTIX", "AEGENTIX-CONSOLIDATED", "aegentix-gh-restructure",
    "AEGENTIX_TREASURY_LABS", "sovereign", "sovereign-prime",
    "sovereign-agent", "Sovereign-Protected-Mirror", "sovereign_dataset",
    "sovae-runtime", "core", "brain", "cybercore",
    "aegentix_cybercore_grove_orchards", "vrv_spec", "sovereign-prime-export.zip",
    "sovereign_dataset.zip", "GENOME.SOVEREIGN.OMEGA.PRIME {.txt",
    "aegentis_asset_inventory.json", "aegentis_control_plane.jsonl",
    "aegentis_convergence.py", "aegentis_infrastructure_brief.json",
    "aegentis_legal_brain.py", "aegentis_rog_core.py",
    "aegentis.js", "bootstrap-sovereign.ps1", "sovereign-install.ps1",
    "start_sov.bat", "install_sov_corp_vr.ps1", "install_sov_corp.ps1",
    "aegentis-mesh.yaml", "aegentis-mesh.yaml.txt",
    "aegentis-nats-search.txt", "aegentis-nats-subs.txt",
    "live_process_inventory.txt", "live_service_inventory.txt",
    "ae.json", "AEGENTIS_HMAC_SECRET-SHARED_SECRET_KEY.txt",
    "AEGENTIX_SELF_VERIFY.ps1", "run_aegentix.ps1",
    "aegentis-launch-all.ps1", "aegentix-bootstrap.sh",
    "verify_agx_asset.py", "verify_hermes.py", "CLAUDE.md"
)
foreach ($item in $coreItems) { Move-ItemSafe $item "$organizedDir\core\" }

# ============================================================
# AGENTS / MESH / SWARMS
# ============================================================
Write-Host "  [.] Sorting agents and mesh..." -ForegroundColor Yellow
$agentItems = @(
    ".agents", "agent", "AE-Hub", "hermes-agent", "guardian-service",
    "sentinel", "worker", ".swarms", ".hermes", ".jarvis",
    "Jarvis-Dashboard", "swarm_agent.py", "swarm_monitor.py",
    "swarm_ping.py", "swarm_status.py", "swarm.json",
    "swarm-transfer-coordinator.mjs", "agent_intercept.sh",
    "autonomy_loop.py", "cy402x_swarm_state.json",
    "run_cybercore_agent.py", "wake_oracle.py", "intent.py",
    "network_api.py", "network_model.json", "pub.py",
    "cybernetic_observer.sh", "harmony_stress_test.py",
    ".jarvis-dashboard.log", ".jarvis-dashboard.pid",
    "jarvis-status.ps1", "hermes_payload.sh",
    "telemetry.json", "telemetry", "event-bus",
    "memory", "config", "state", "snapshots",
    "voice-stack.yaml", "voice-stack-webhook.yaml",
    "twin.yaml", "twin-router-patch.yaml",
    "router.yaml", "registry.yaml", "console.yaml",
    "aegentix_node.py", "agent_loop.py", "dove_v1.py",
    "hermes install via powershell current status.txt"
)
foreach ($item in $agentItems) { Move-ItemSafe $item "$organizedDir\agents\" }

# ============================================================
# MCP
# ============================================================
Write-Host "  [.] Sorting MCP servers..." -ForegroundColor Yellow
$mcpItems = @("aegentis-mcp", "aegentix-mcp", ".claude", ".overture", ".codex", ".codesouler")
foreach ($item in $mcpItems) { Move-ItemSafe $item "$organizedDir\mcp\" }

# ============================================================
# INFRASTRUCTURE
# ============================================================
Write-Host "  [.] Sorting infrastructure..." -ForegroundColor Yellow
$infraItems = @(
    ".aws", ".azure", ".kube", ".minikube", ".vs-kubernetes",
    ".docker", ".dockerignore", ".docker_aegentis_compose.log",
    "main.py", "main.tf", "terraform",
    "deploy-nexus-via-ssh.ps1", "nexus-deploy.sh",
    "nexus-batch-push.ps1", "orchestrate-nexus-deployment.ps1",
    "EC2-EXECUTION-PLAN.sh", "PASTE-IN-EC2-TERMINAL.sh",
    "ec2-check-nexus.sh", "ec2-nexus-diagnostics.sh",
    "diagnose-orbital-stack.sh", "fix-autoheal.sh",
    "classify-exited-services.sh", "batch-push-final.ps1",
    "aegentis-launch-all.ps1", "launch-aegentix-ec2.sh",
    "nexus_sync", "nexus_sync.ps1", "nexus_sync.ps1.txt",
    "install_tsl_integration.sh", "env.json",
    "nodes.json", "plan.json", "payload.json",
    "install_sov_corp_vr.ps1", "install_sov_corp.ps1",
    "architecturediscovery-summary.txt", "architecture-discovery.txt",
    "EXECUTION-GUIDE.txt", "WORKFLOW-GUIDE.txt",
    "skills-lock.json", "response.json",
    "ngrok", "ngrok.zip", "platform-tools", "platform-tools.zip",
    ".chocolatey"
)
foreach ($item in $infraItems) { Move-ItemSafe $item "$organizedDir\infrastructure\" }

# Scripts specifically
$scriptItems = @(
    "bootstrap.sh", "install", "install.js", "install.ts",
    "fix-runtime.js", "mytest.js", "simulate_srp.js",
    "aegentis.js", "fix-runtime_files",
    "github_cli_auth_handoff.ps1", "run_aegentix.ps1"
)
foreach ($item in $scriptItems) { Move-ItemSafe $item "$organizedDir\infrastructure\scripts\" }

# ============================================================
# CONTAINERS
# ============================================================
Write-Host "  [.] Sorting containers..." -ForegroundColor Yellow
$containerItems = @(
    "docker-compose.yml", "docker-compose.aegentis-console.yml",
    "Dockerfile", "Dockerfile.aegentis-console"
)
foreach ($item in $containerItems) { Move-ItemSafe $item "$organizedDir\containers\" }

# ============================================================
# SECURITY
# ============================================================
Write-Host "  [.] Sorting security..." -ForegroundColor Yellow
$securityItems = @(
    "identity", "triage", "incidents", "sentinel",
    ".ssh", "rescue-key.pem", "aegentix-key.pem",
    "avk1_validator.py",
    "aegentix_today_dump.txt",
    "aegentis_mesh.yaml", "aegentis_mesh.yaml.txt"
)
foreach ($item in $securityItems) { Move-ItemSafe $item "$organizedDir\security\" }

# ============================================================
# FINANCIAL
# ============================================================
Write-Host "  [.] Sorting financial..." -ForegroundColor Yellow
$financialItems = @(
    "AutoHedge", "crypto-arbitrage-bot-automated-trading",
    "arbitrage_demo.py", "coinbase-readonly-key.json",
    "aegentix_coinbase_activation", "aegentix-coinbase-advtrade.zip",
    "pnl-nexus.pid"
)
foreach ($item in $financialItems) { Move-ItemSafe $item "$organizedDir\financial\" }

# ============================================================
# LEGAL
# ============================================================
Write-Host "  [.] Sorting legal..." -ForegroundColor Yellow
$legalItems = @(
    "aegentis_legal_brain.py", "starship_law_core",
    "LICENSE.txt", "legal-swarm.json"
)
foreach ($item in $legalItems) { Move-ItemSafe $item "$organizedDir\legal\" }

# ============================================================
# ORCHESTRATORS
# ============================================================
Write-Host "  [.] Sorting orchestrators..." -ForegroundColor Yellow
$orchItems = @(
    "orchestrator.py", "orchestrator-test.json", "orchestrator.zip",
    "planner.py", "planner-test.json", "planner.zip",
    "nexus_enterprise.py", "nexus_mc.py", "nexus-exec.json",
    "starship_eternal", "starship_factory",
    "phase2.yaml", "phase3", "phase3-cosmic",
    "phase4-quantum", "phase5-transcendent",
    "phase6", "phase6-omnipotent",
    "cycle-log.txt", "serve_web_dashboard.py",
    "view_dashboard.py"
)
foreach ($item in $orchItems) { Move-ItemSafe $item "$organizedDir\orchestrators\" }

# ============================================================
# LAMBDAS
# ============================================================
Write-Host "  [.] Sorting lambdas..." -ForegroundColor Yellow
$lambdaItems = @("lambda-pkg", "lambdas_functions", "poller.py")
foreach ($item in $lambdaItems) { Move-ItemSafe $item "$organizedDir\lambdas\" }

# ============================================================
# LOGS
# ============================================================
Write-Host "  [.] Sorting logs..." -ForegroundColor Yellow
$logItems = @(
    "logs", ".python_history", ".bash_history",
    "runtime.log", ".jarvis-dashboard.log", "telemetry.json",
    ".docker_aegentis_compose.log", "cycle-log.txt"
)
foreach ($item in $logItems) { Move-ItemSafe $item "$organizedDir\logs\" }

# ============================================================
# ARCHIVES
# ============================================================
Write-Host "  [.] Sorting archives..." -ForegroundColor Yellow
$archiveItems = @(
    "aegentix-nexus-distribute-*", "*_backup*", "*.zip",
    "obsidia", "dist", "setup_guide*", "ESS7-Bundle-Builder*",
    "forger", "templateengine", "v6rge",
    "C_DRIVE_MIRROR_FILTERED.txt"
)
foreach ($item in $archiveItems) {
    Get-ChildItem -Path $homeDir -Name $item -ErrorAction SilentlyContinue | ForEach-Object {
        Move-ItemSafe $_ "$organizedDir\archives\"
    }
}
# Specific archive items
$archiveFiles = @(
    "Golden Omega Crest Design.mhtml",
    "AE.png", "442d8b43-ee8b-47d7-9f7c-2b825c0d8203.png",
    "af93793c-eda8-407a-9431-44b38f7956cd.png",
    "d96585f1-d886-402e-a3b9-fe5c5cc52382.png",
    "Setup Guide In-Editor Tutorial",
    "ESS7-Bundle-Builder_files", "ESS7-Bundle-Builder.ps1",
    "vs_BuildTools.exe", "platform-tools.zip",
    "oculus-adb-driver", ".landscape",
    "sovereign-prime-export.zip", "sovereign_dataset.zip",
    "ROG Ally's target IP address on your local network is 172.25.96.56.txt"
)
foreach ($item in $archiveFiles) { Move-ItemSafe $item "$organizedDir\archives\" }

# ============================================================
# PROJECTS
# ============================================================
Write-Host "  [.] Sorting projects..." -ForegroundColor Yellow
$projectItems = @(
    "NemoClaw", "NeMo", "laniakea-dashboard", "laniakea-mobile-app",
    "EagleShieldUnity", "EAGLE-SHIELD", "Grafana-Observability-Stack",
    "horizon-v0.6", "mantis-core", "medic",
    "code", "claw", "obsidia",
    "obsidian-jupyter-agent-integration",
    "Obsidian", "origin", "crypto-arbitrage-bot-automated-trading",
    "src", "backend", "app", "gemini-cli",
    "CrossDevice", "forge", "ovae-runtime",
    "worldmonitor", "osint",
    ".app-store", ".expo", ".openclaw",
    "Unity user templates"
)
foreach ($item in $projectItems) { Move-ItemSafe $item "$organizedDir\projects\" }

# ============================================================
# DEV TOOLS
# ============================================================
Write-Host "  [.] Sorting dev tools..." -ForegroundColor Yellow
$devAndroid = @(".android", ".gradle", "platform-tools", "oculus-adb-driver")
foreach ($item in $devAndroid) { Move-ItemSafe $item "$organizedDir\dev\android\" }

$devNode = @("node_modules", "npm-global", ".npmrc", "package.json", "package-lock.json", "nvm-setup.exe")
foreach ($item in $devNode) { Move-ItemSafe $item "$organizedDir\dev\node\" }

$devPython = @("venv", ".venvs", ".pytest_cache")
foreach ($item in $devPython) { Move-ItemSafe $item "$organizedDir\dev\python\" }

$devDotnet = @(".dotnet", ".nuget")
foreach ($item in $devDotnet) { Move-ItemSafe $item "$organizedDir\dev\dotnet\" }

$devUnity = @("Unity user templates")
foreach ($item in $devUnity) { Move-ItemSafe $item "$organizedDir\dev\unity\" }

# General dev
$devGeneral = @(
    ".vscode", ".vscode-shared", ".ollama",
    ".copilot", ".chatgpt-copilot", ".kimi",
    ".kimi_openclaw", ".kimi-webbridge", ".moltbook",
    ".codex", ".codesouler", ".cagent",
    "test_quick.py", "send_test.py",
    ".hzdb", ".openclaw"
)
foreach ($item in $devGeneral) { Move-ItemSafe $item "$organizedDir\dev\" }

# ============================================================
# CONFIGS
# ============================================================
Write-Host "  [.] Sorting configs..." -ForegroundColor Yellow
$configItems = @(
    ".config", ".local", ".cache", ".gitconfig", ".gitignore",
    "mail-config", "mail-data", "mail-state",
    "metrics", "training_response.json",
    ".claude.json"
)
foreach ($item in $configItems) { Move-ItemSafe $item "$organizedDir\configs\" }

# ============================================================
# RUN TIME
# ============================================================
Write-Host "  [.] Sorting runtime..." -ForegroundColor Yellow
$runtimeItems = @(
    "runtime", "_cache", "__pycache__", "dist", "build-logs"
)
foreach ($item in $runtimeItems) { Move-ItemSafe $item "$organizedDir\runtime\" }

# ============================================================
# LEDGER
# ============================================================
Write-Host "  [.] Sorting ledger..." -ForegroundColor Yellow
$ledgerItems = @(
    "ledger", "interstellar_payload_bundle.dat"
)
foreach ($item in $ledgerItems) { Move-ItemSafe $item "$organizedDir\ledger\" }

# ============================================================
# TRASH — literal commands, stray junk
# ============================================================
Write-Host "  [.] Isolating trash..." -ForegroundColor Yellow
$trashItems = @(
    "{", "@echo", "cd", "echo", "set", "setlocal",
    "REM", "Decide", "Evaluate", "ExecTask",
    "Idle", "Integrate", "Interact", "Observe", "Update",
    "ponse.json",
    "ROG Ally's target IP address on your local network is 172.25.96.56.txt"
)
foreach ($item in $trashItems) { Move-ItemSafe $item "$organizedDir\trash\" }

# ============================================================
# GENERATE INDEXES
# ============================================================
Write-Host "  [.] Generating index files..." -ForegroundColor Yellow
Get-ChildItem -Path $organizedDir -Directory | ForEach-Object {
    $indexPath = Join-Path $_.FullName "index.md"
    $contents = Get-ChildItem -Path $_.FullName -Name | Where-Object { $_ -ne "index.md" }
    $body = @"
# $($_.Name)

Contents of ``$($_.FullName)``:

``````
$($contents -join "`n")
``````
"@
    $body | Out-File -FilePath $indexPath -Encoding UTF8
}

# ============================================================
# MASTER README
# ============================================================
Write-Host "  [.] Generating master README..." -ForegroundColor Yellow
$readme = @"
# AEGENTIS — Organized Windows Profile

**Host:** $env:COMPUTERNAME
**Date:** $(Get-Date)

## Structure

| Folder | Purpose |
|--------|---------|
| `core/` | Core AEGENTIS systems, sovereign OS, boot, gen, labs, cybercore |
| `agents/` | Agent mesh, AE-Hub, Hermes, Oracle, Guardian, skills, swarms |
| `mcp/` | MCP servers, Claude, Codex, Overture configs |
| `infrastructure/` | AWS/Azure/Kube configs, deployment scripts, Terraform |
| `containers/` | Docker compose, Dockerfiles |
| `security/` | SSH keys, identity, triage, incidents, sentinel |
| `financial/` | Coinbase, arbitrage bots, AutoHedge |
| `legal/` | Legal brain, licenses |
| `orchestrators/` | Orchestrator, planner, nexus, phases |
| `lambdas/` | Lambda function packages |
| `logs/` | All log files, Python history |
| `archives/` | Old zips, images, deprecated installers |
| `ledger/` | Ledger data |
| `runtime/` | Build cache, dist, runtime artifacts |
| `osint/` | OSINT tools |
| `configs/` | Git config, mail, metrics, Claude.json |
| `dev/` | Android SDK, Node, Python, .NET, Unity, Ollama |
| `projects/` | NemoClaw, Laniakea, EagleShield, Grafana, etc. |
| `trash/` | Junk — literal commands as filenames. Safe to delete. |

## Original State Backup
``$backupDir\listing_before.txt``
"@
$readme | Out-File -FilePath "$organizedDir\README.md" -Encoding UTF8

# ============================================================
# FINAL REPORT
# ============================================================
Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "  ║   ORGANIZATION COMPLETE                          ║" -ForegroundColor Green
Write-Host "  ╠══════════════════════════════════════════════════╣" -ForegroundColor Green
Write-Host "  ║  New root:    $organizedDir" -ForegroundColor Green
Write-Host "  ║  Backup:      $backupDir\listing_before.txt" -ForegroundColor Green
Write-Host "  ║  README:      $organizedDir\README.md" -ForegroundColor Green
Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "  Items remaining in $homeDir (not moved):" -ForegroundColor Yellow
Get-ChildItem -Path $homeDir -Name -Force | ForEach-Object { Write-Host "    $_" }
Write-Host ""
