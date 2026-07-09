# AEGENTIS Universal Home Organizer

Organizes any messy AEGENTIS home directory into a clean categorized structure. Three scripts — one for each environment.

## Quick Start

### AWS CloudShell
```bash
curl -O https://raw.githubusercontent.com/shalominattii-us/aegentis-cloudshell-organizer/main/organize.sh
chmod +x organize.sh && bash organize.sh
```

### EOC / WSL (Linux)
```bash
curl -O https://raw.githubusercontent.com/shalominattii-us/aegentis-cloudshell-organizer/main/organize.sh
chmod +x organize.sh && bash organize.sh
```

### Windows (PowerShell as Administrator)
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
iwr -Uri https://raw.githubusercontent.com/shalominattii-us/aegentis-cloudshell-organizer/main/organize-windows.ps1 -OutFile organize-windows.ps1
.\organize-windows.ps1
```

## What It Does

- Creates categorized folders under `organized/`
- Moves every file/directory into the right category based on naming conventions
- Isolates junk (literal bash commands saved as filenames) into `trash/`
- Generates `index.md` per folder + master `README.md`
- Creates `.hushlogin` (Linux/WSL)
- **Never deletes** — backup listing saved before moving

## Directory Structure

| Folder | Purpose |
|--------|---------|
| `core/` | Core AEGENTIS systems, sovereign OS, boot, gen, labs, cybercore |
| `agents/` | Agent mesh, AE-Hub, Hermes, Oracle, Guardian, skills, swarms |
| `mcp/` | MCP server implementations, Claude, Codex, Overture |
| `infrastructure/` | Terraform, AWS/Azure/Kube configs, deployment scripts |
| `containers/` | Docker compose, ECR, Nexus registry, Dockerfiles |
| `security/` | Patches, IAM inventories, shields, DFIR, SSH keys |
| `financial/` | Coinbase activations, arbitrage bots, AutoHedge |
| `legal/` | Legal brain, swarm contracts, licenses |
| `orchestrators/` | Orchestrator, planner, nexus, phases, starships |
| `lambdas/` | Lambda function packages |
| `logs/` | All log files, shell history |
| `archives/` | Old distributions, deprecated code, zips, images |
| `ledger/` | Ledger data, payload bundles |
| `runtime/` | Python cache, build artifacts |
| `osint/` | OSINT tools, world monitor |
| `configs/` | Git config, mail, metrics, SSH, desktop |
| `dev/` | Android SDK, Node, Python, .NET, Unity, Ollama |
| `projects/` | NemoClaw, Laniakea, EagleShield, Grafana, etc. |
| `trash/` | Junk — literal commands as filenames. Safe to delete. |
