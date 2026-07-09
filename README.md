# AEGENTIS Universal Home Organizer

Auto-detects environment (CloudShell, WSL/EOC, Linux) and organizes any messy home directory (`~`) into a clean categorized structure under `~/organized/`.

## Quick Start

```bash
curl -O https://raw.githubusercontent.com/shalominattii-us/aegentis-cloudshell-organizer/main/organize.sh
chmod +x organize.sh
bash organize.sh
```

## What It Does

- Creates **17 categorized folders** under `~/organized/`
- Moves every file/directory from `~` into the right category
- Isolates junk (literal bash commands saved as filenames) into `trash/`
- Generates `index.md` in each folder
- Generates a master `README.md` with a full directory map
- **Never deletes anything** — a backup listing of the original state is saved

## Directory Structure

| Folder | Purpose |
|--------|---------|
| `core/` | Core AEGENTIS systems, sovereign OS, boot, gen, labs, cybercore |
| `agents/` | Agent mesh, AE-Hub, Hermes, Oracle, Guardian, skills |
| `mcp/` | MCP server implementations |
| `infrastructure/` | Terraform, main.tf, deployment scripts |
| `containers/` | Docker compose, ECR, Nexus registry |
| `security/` | Security patches, IAM inventories, shields, DFIR |
| `financial/` | Coinbase activations, keys |
| `legal/` | Legal brain, swarm contracts, licenses |
| `orchestrators/` | Orchestrator, planner, nexus, phases, starships |
| `lambdas/` | Lambda function packages |
| `logs/` | All log files |
| `archives/` | Old distributions, deprecated code, zips |
| `ledger/` | Ledger data |
| `runtime/` | Python cache, runtime artifacts |
| `osint/` | OSINT tools, world monitor |
| `configs/` | Keys, reports, test data, graph |
| `trash/` | Junk — literal commands, stray flags. Safe to delete. |
