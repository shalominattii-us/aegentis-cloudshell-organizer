#!/bin/bash
# ============================================================
# AEGENTIS Universal Home Directory Organizer
# Auto-detects environment (CloudShell, EOC/WSL, Linux) and
# organizes ~/ into a clean ~/organized/ structure.
# Safe: moves only, never deletes. Generates indexes.
# ============================================================
set -e

echo ""
echo "  ╔══════════════════════════════════════════════════╗"
echo "  ║   AEGENTIS UNIVERSAL HOME ORGANIZER              ║"
echo "  ╚══════════════════════════════════════════════════╝"
echo ""

touch ~/.hushlogin
echo "  [.] .hushlogin created"

BACKUP_DIR=~/organized_bak_$(date +%Y%m%d_%H%M%S)
mkdir -p "$BACKUP_DIR"
ls -la ~ > "$BACKUP_DIR/listing_before.txt"
echo "  [.] Backup listing saved to $BACKUP_DIR/listing_before.txt"

# Detect environment
HOSTNAME=$(hostname 2>/dev/null || echo "unknown")
if echo "$HOSTNAME" | grep -qi "cloudshell\|ip-10-"; then
    ENV="cloudshell"
elif grep -qi "microsoft\|wsl" /proc/version 2>/dev/null; then
    ENV="wsl"
elif [ -n "$WSL_DISTRO_NAME" ]; then
    ENV="wsl"
else
    ENV="linux"
fi
echo "  [.] Environment detected: $ENV"

# ============================================================
# CREATE DIRECTORY STRUCTURE
# ============================================================
echo "  [.] Creating organized directory structure..."
mkdir -p ~/organized/{core,agents,mcp,infrastructure/{terraform,scripts},containers,security,financial,legal,orchestrators,lambdas,logs,archives,configs,osint,ledger,runtime,trash,dev/{android,node,python},projects}

cd ~

# ============================================================
# MOVE FUNCTION - silent, no error on missing
# ============================================================
move() { mv "$1" "$2" 2>/dev/null || true; }

# ============================================================
# CORE SYSTEMS (AEGENTIS, SOVEREIGN)
# ============================================================
echo "  [.] Sorting core AEGENTIS systems..."
move aegentis-prime-core    ~/organized/core/
move aegentis_stabilization_kernel.sh ~/organized/core/
move sovereign-prime        ~/organized/core/
move sovereign-stack        ~/organized/core/
move sovereign-os           ~/organized/core/
move sovereign-eoc          ~/organized/core/
move sovereign-persist      ~/organized/core/
move sovereign-cloudshell-push ~/organized/core/
move AEGENTIS               ~/organized/core/
move AEGENTIX               ~/organized/core/
move AEGENTIS_LOCAL         ~/organized/core/
move aegentix                ~/organized/core/
move aegentis                ~/organized/core/
move aegentis-env            ~/organized/core/
move aegentis-origin         ~/organized/core/
move aegentix_env            ~/organized/core/
move _core                  ~/organized/core/
move core                   ~/organized/core/
move _boot                  ~/organized/core/
move _active                ~/organized/core/
move device                 ~/organized/core/
move gen01                  ~/organized/core/
move gen02                  ~/organized/core/
move gen03                  ~/organized/core/
move labs                   ~/organized/core/
move kimitron               ~/organized/core/
move cybercore              ~/organized/core/
move brain                  ~/organized/core/
move manus-integration      ~/organized/core/
move vault                  ~/organized/core/
move _vr                    ~/organized/core/
move 'C:SOVEREIGNDXVR'      ~/organized/core/ 2>/dev/null || true

# ============================================================
# AGENTS / MESH
# ============================================================
echo "  [.] Sorting agents and mesh..."
move _agents                 ~/organized/agents/
move -agents                 ~/organized/agents/
move agents                  ~/organized/agents/
move aegentix-agent-mesh     ~/organized/agents/
move aegentix-email          ~/organized/agents/
move AE-Hub                  ~/organized/agents/
move arena                   ~/organized/agents/
move hermes                  ~/organized/agents/
move oracle                  ~/organized/agents/
move guardian                ~/organized/agents/
move skills                  ~/organized/agents/
move monitors                ~/organized/agents/
move vectors                 ~/organized/agents/
move features                ~/organized/agents/
move _misc                   ~/organized/agents/
move agent_loop.py           ~/organized/agents/
move dove_v1.py              ~/organized/agents/
move aegentix_node.py        ~/organized/agents/
move cybernetic_observer.sh  ~/organized/agents/
move .jarvis                 ~/organized/agents/
move .nemoclaw               ~/organized/agents/

# ============================================================
# MCP
# ============================================================
echo "  [.] Sorting MCP servers..."
move aegentis-mcp            ~/organized/mcp/
move aegentix-mcp            ~/organized/mcp/

# ============================================================
# INFRASTRUCTURE
# ============================================================
echo "  [.] Sorting infrastructure..."
move main.tf                 ~/organized/infrastructure/terraform/
move main.py                 ~/organized/infrastructure/
move terraform               ~/organized/infrastructure/terraform/
move modules                 ~/organized/infrastructure/terraform/
move _deployments            ~/organized/infrastructure/
move _infra                  ~/organized/infrastructure/
move launch-aegentix-ec2.sh  ~/organized/infrastructure/scripts/
move start-aegentix-business.sh ~/organized/infrastructure/scripts/
move start-aegentix-groves.sh   ~/organized/infrastructure/scripts/
move verify-aegentix.sh      ~/organized/infrastructure/scripts/
move install-aegentis.sh     ~/organized/infrastructure/scripts/
move install-aegentis.sh.save ~/organized/infrastructure/scripts/
move build.sh                ~/organized/infrastructure/scripts/
move nexus_sync.sh           ~/organized/infrastructure/scripts/
move eagle-shield-substrate  ~/organized/infrastructure/
move aegentis-cloud-sync     ~/organized/infrastructure/
move .kube                   ~/organized/infrastructure/
move .aws                    ~/organized/infrastructure/
move .azure                  ~/organized/infrastructure/

# ============================================================
# CONTAINERS
# ============================================================
echo "  [.] Sorting containers..."
move docker-compose-nexus.yml ~/organized/containers/
move docker-compose.yml       ~/organized/containers/
move nexus-data               ~/organized/containers/
move nexus-registry           ~/organized/containers/
move _registry                ~/organized/containers/
move .docker                  ~/organized/containers/ 2>/dev/null || true

# ============================================================
# SECURITY
# ============================================================
echo "  [.] Sorting security..."
move aegentis-security-patch  ~/organized/security/
move secure_patch             ~/organized/security/
move _security                ~/organized/security/
move shields                  ~/organized/security/
move aws-iam-security-inventory-20260707T181845Z ~/organized/security/
move aws-iam-security-inventory-20260707T181845Z.zip ~/organized/security/
move safe-iam-inventory.sh    ~/organized/security/
move dfir                     ~/organized/security/
move rescue-key.pem           ~/organized/security/
move aegentix-key.pem         ~/organized/security/

# ============================================================
# FINANCIAL
# ============================================================
echo "  [.] Sorting financial..."
move aegentix_coinbase_activation ~/organized/financial/
move aegentix_coinbase_activation.zip ~/organized/financial/
move aegentix-coinbase-advtrade.zip ~/organized/financial/
move coinbase-readonly-key.json ~/organized/financial/

# ============================================================
# LEGAL
# ============================================================
echo "  [.] Sorting legal..."
move aegentis_legal_brain     ~/organized/legal/
move legal-swarm.json         ~/organized/legal/
move starship_law_core        ~/organized/legal/
move LICENSE.txt              ~/organized/legal/

# ============================================================
# ORCHESTRATORS
# ============================================================
echo "  [.] Sorting orchestrators..."
move orchestrator.py          ~/organized/orchestrators/
move orchestrator-test.json   ~/organized/orchestrators/
move orchestrator.zip         ~/organized/orchestrators/
move planner.py               ~/organized/orchestrators/
move planner-test.json        ~/organized/orchestrators/
move planner.zip              ~/organized/orchestrators/
move plan.json                ~/organized/orchestrators/
move nexus_enterprise.py      ~/organized/orchestrators/
move nexus_mc.py              ~/organized/orchestrators/
move nexus-exec.json          ~/organized/orchestrators/
move nexus_enterprise         ~/organized/orchestrators/
move starship_eternal         ~/organized/orchestrators/
move starship_factory         ~/organized/orchestrators/
move content                  ~/organized/orchestrators/
move domains                  ~/organized/orchestrators/
move orbits                   ~/organized/orchestrators/
move phase2.yaml              ~/organized/orchestrators/ 2>/dev/null || true
move phase3                   ~/organized/orchestrators/ 2>/dev/null || true
move phase3-cosmic            ~/organized/orchestrators/ 2>/dev/null || true
move phase4-quantum           ~/organized/orchestrators/ 2>/dev/null || true
move phase5-transcendent      ~/organized/orchestrators/ 2>/dev/null || true
move phase6                   ~/organized/orchestrators/ 2>/dev/null || true
move phase6-omnipotent        ~/organized/orchestrators/ 2>/dev/null || true

# ============================================================
# LAMBDAS
# ============================================================
echo "  [.] Sorting lambdas..."
move lambda-pkg               ~/organized/lambdas/
move _lambdas                 ~/organized/lambdas/

# ============================================================
# PROJECTS (NemoClaw, Laniakea, etc.)
# ============================================================
echo "  [.] Sorting projects..."
move NemoClaw                 ~/organized/projects/
move laniakea                 ~/organized/projects/
move laniakea-mobile          ~/organized/projects/
move app                      ~/organized/projects/
move android-sdk              ~/organized/dev/android/
move .android                 ~/organized/dev/android/ 2>/dev/null || true
move .gradle                  ~/organized/dev/android/ 2>/dev/null || true
move .java                    ~/organized/dev/ 2>/dev/null || true
move .groovy                  ~/organized/dev/ 2>/dev/null || true

# ============================================================
# DEV TOOLS / RUNTIMES
# ============================================================
echo "  [.] Sorting dev tools..."
move .npm                     ~/organized/dev/node/ 2>/dev/null || true
move .nvm                     ~/organized/dev/node/ 2>/dev/null || true
move .bun                     ~/organized/dev/node/ 2>/dev/null || true
move .pyenv                   ~/organized/dev/python/ 2>/dev/null || true
move venv                     ~/organized/dev/python/ 2>/dev/null || true
move .ollama                  ~/organized/dev/ 2>/dev/null || true
move .vscode-remote-containers ~/organized/dev/ 2>/dev/null || true
move .brev                    ~/organized/dev/ 2>/dev/null || true
move package-lock.json        ~/organized/dev/node/ 2>/dev/null || true

# ============================================================
# LOGS
# ============================================================
echo "  [.] Sorting logs..."
move ledger_A.log             ~/organized/logs/
move ledger_C.log             ~/organized/logs/
move cleanup_swarm.log        ~/organized/logs/
move _logs                    ~/organized/logs/
move flask_server.log         ~/organized/logs/
move server.log               ~/organized/logs/
move mesh_sync.log            ~/organized/logs/
move aegentix_init.log        ~/organized/logs/
move .wget-hsts               ~/organized/logs/

# ============================================================
# ARCHIVES
# ============================================================
echo "  [.] Sorting archives..."
move _archives                ~/organized/archives/
move _deprecated              ~/organized/archives/
move aegentix-nexus-distribute-20260705-215324 ~/organized/archives/
move aegentix-nexus-distribute-20260705-215634 ~/organized/archives/
move aegentix_cybercore_grove_orchards ~/organized/archives/
move aegentix_cybercore_grove_orchards.zip ~/organized/archives/
move .landscape               ~/organized/archives/ 2>/dev/null || true

# ============================================================
# LEDGER
# ============================================================
echo "  [.] Sorting ledger..."
move _ledger                  ~/organized/ledger/
move ledger                   ~/organized/ledger/
move interstellar_payload_bundle.dat ~/organized/ledger/

# ============================================================
# RUNTIME
# ============================================================
echo "  [.] Sorting runtime..."
move _runtime                 ~/organized/runtime/
move runtime                  ~/organized/runtime/
move __pycache__              ~/organized/runtime/ 2>/dev/null || true

# ============================================================
# OSINT
# ============================================================
echo "  [.] Sorting OSINT..."
move osint                    ~/organized/osint/
move worldmonitor             ~/organized/osint/

# ============================================================
# CONFIGS
# ============================================================
echo "  [.] Sorting configs..."
move response.json            ~/organized/configs/
move _report                  ~/organized/configs/
move _tests                   ~/organized/configs/
move _graph                   ~/organized/configs/
move tools                    ~/organized/configs/
move bash                     ~/organized/configs/
move .wsl-config              ~/organized/configs/
move .ssh                     ~/organized/configs/
move Desktop                  ~/organized/configs/
move Downloads                ~/organized/configs/
move .dbus                    ~/organized/configs/ 2>/dev/null || true
move .config                  ~/organized/configs/ 2>/dev/null || true  # Only extra non-standard .config
move .local                   ~/organized/configs/ 2>/dev/null || true
move .cache                   ~/organized/configs/ 2>/dev/null || true
move snap                     ~/organized/configs/ 2>/dev/null || true

# ============================================================
# TRASH
# ============================================================
echo "  [.] Isolating junk..."
move '==="'                   ~/organized/trash/ 2>/dev/null || true
move '-d'                     ~/organized/trash/ 2>/dev/null || true
move '-H'                     ~/organized/trash/ 2>/dev/null || true
move '-p'                     ~/organized/trash/ 2>/dev/null || true
move 'a'                      ~/organized/trash/ 2>/dev/null || true
move '--docker-password='     ~/organized/trash/ 2>/dev/null || true
move '--docker-server=205718953513.dkr.ecr.us-west-1.amazonaws.com' ~/organized/trash/ 2>/dev/null || true
move '--docker-username=AWS'  ~/organized/trash/ 2>/dev/null || true
move 'ec2 describe-instances --region us-west-1 --filters Name=instance-state-name,Values=running --query Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value|[0],InstanceType,State.Name] --output table' ~/organized/trash/ 2>/dev/null || true
move 'ecs wait services-stable \' ~/organized/trash/ 2>/dev/null || true
move "'-fixed-\$A-\$R\"'"    ~/organized/trash/ 2>/dev/null || true
move "'-multiversal-god (10240 MB) ✅\"'" ~/organized/trash/ 2>/dev/null || true
move '-phase2.yaml'           ~/organized/trash/ 2>/dev/null || true
move '.build.sh.swp'          ~/organized/trash/ 2>/dev/null || true
move nul                      ~/organized/trash/ 2>/dev/null || true

# ============================================================
# GENERATE INDEXES
# ============================================================
echo "  [.] Generating index files..."
for dir in ~/organized/*/; do
    dirname=$(basename "$dir")
    {
        echo "# $dirname"
        echo ""
        echo "Contents of \`~/organized/$dirname/\`:"
        echo ""
        echo '```'
        ls "$dir" 2>/dev/null | grep -v index.md || echo "(empty)"
        echo '```'
    } > "$dir/index.md"
done

# ============================================================
# MASTER README
# ============================================================
echo "  [.] Generating master README..."
cat > ~/organized/README.md << EOF
# AEGENTIS — Organized Directory

**Environment:** $ENV
**Host:** $HOSTNAME
**Date:** $(date)

## Structure

| Folder | Purpose |
|--------|---------|
| \`core/\` | Core AEGENTIS systems, sovereign OS, boot, gen, labs, cybercore |
| \`agents/\` | Agent mesh, AE-Hub, Hermes, Oracle, Guardian, skills |
| \`mcp/\` | MCP server implementations |
| \`infrastructure/\` | Terraform, deployment scripts, AWS/Azure configs |
| \`containers/\` | Docker compose, ECR, Nexus registry |
| \`security/\` | Patches, IAM inventories, shields, DFIR, keys |
| \`financial/\` | Coinbase activations, keys |
| \`legal/\` | Legal brain, swarm contracts, licenses |
| \`orchestrators/\` | Orchestrator, planner, nexus, phases, starships |
| \`lambdas/\` | Lambda function packages |
| \`logs/\` | All log files |
| \`archives/\` | Old distributions, deprecated code, zips |
| \`ledger/\` | Ledger data, payload bundles |
| \`runtime/\` | Python cache, runtime artifacts |
| \`osint/\` | OSINT tools, world monitor |
| \`configs/\` | Keys, reports, SSH, desktop, cache |
| \`dev/\` | Android SDK, Node, Python, Gradle |
| \`projects/\` | NemoClaw, Laniakea, app |
| \`trash/\` | Junk — literal commands, stray flags. Safe to delete. |

## Original State Backup
\`$BACKUP_DIR/listing_before.txt\`
EOF

# ============================================================
# FINAL REPORT
# ============================================================
echo ""
echo "  ╔══════════════════════════════════════════════════╗"
echo "  ║   ORGANIZATION COMPLETE                          ║"
echo "  ╠══════════════════════════════════════════════════╣"
echo "  ║  Environment: $ENV"
echo "  ║  New root:    ~/organized/"
echo "  ║  Backup:      $BACKUP_DIR/listing_before.txt"
echo "  ║  README:      ~/organized/README.md"
echo "  ╚══════════════════════════════════════════════════╝"
echo ""
echo "  Items remaining in ~ (not moved — review manually):"
echo "  ───────────────────────────────────────────────────"
ls -1a ~ 2>/dev/null | grep -v "^\.$" | grep -v "^\.\.$" | grep -v "^organized" | grep -v "^organized_bak_" | grep -v "^\.bash_history$" | grep -v "^\.bashrc$" | grep -v "^\.profile$" | grep -v "^\.bash_logout$" | grep -v "^\.motd_shown$" | grep -v "^\.hushlogin$" || echo "  (none — everything sorted!)"
echo "  ───────────────────────────────────────────────────"
echo ""
echo "  Note: .bashrc, .profile, .bash_history were"
echo "  intentionally left in ~/ for shell operation."
echo ""
