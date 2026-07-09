#!/bin/bash
set -e

# ============================================================
# AEGENTIS CloudShell Home Directory Organizer
# Creates a clean ~/organized/ structure and sorts everything
# Safe: only moves, never deletes. Creates index.md for each folder.
# ============================================================

BACKUP_DIR=~/organized_$(date +%Y%m%d_%H%M%S)
echo "[1/5] Creating backup listing..."
mkdir -p "$BACKUP_DIR"
ls -la ~ > "$BACKUP_DIR/listing_before.txt"

echo "[2/5] Creating organized directory structure..."

# --- Directory layout ---
mkdir -p ~/organized/{core,agents,mcp,infrastructure/{terraform,scripts},containers,security,financial,legal,orchestrators,lambdas,logs,archives,configs,osint,ledger,runtime,trash}

# Change into home to use relative paths safely
cd ~

# ============================================================
# CORE SYSTEMS
# ============================================================
echo "[3/5] Moving files into categories..."

mv aegentis-prime-core ~/organized/core/ 2>/dev/null || true
mv aegentis_stabilization_kernel.sh ~/organized/core/ 2>/dev/null || true
mv sovereign-prime ~/organized/core/ 2>/dev/null || true
mv sovereign-stack ~/organized/core/ 2>/dev/null || true
mv sovereign-os ~/organized/core/ 2>/dev/null || true
mv sovereign-eoc ~/organized/core/ 2>/dev/null || true
mv sovereign-persist ~/organized/core/ 2>/dev/null || true
mv sovereign-cloudshell-push ~/organized/core/ 2>/dev/null || true
mv AEGENTIS ~/organized/core/ 2>/dev/null || true
mv AEGENTIX ~/organized/core/ 2>/dev/null || true
mv aegentix ~/organized/core/ 2>/dev/null || true
mv _core ~/organized/core/ 2>/dev/null || true
mv core ~/organized/core/ 2>/dev/null || true
mv _boot ~/organized/core/ 2>/dev/null || true
mv _active ~/organized/core/ 2>/dev/null || true
mv device ~/organized/core/ 2>/dev/null || true

# ============================================================
# AGENTS / MESH
# ============================================================
mv _agents ~/organized/agents/ 2>/dev/null || true
mv -agents ~/organized/agents/ 2>/dev/null || true
mv agents ~/organized/agents/ 2>/dev/null || true
mv aegentix-agent-mesh ~/organized/agents/ 2>/dev/null || true
mv aegentix-email ~/organized/agents/ 2>/dev/null || true
mv AE-Hub ~/organized/agents/ 2>/dev/null || true
mv arena ~/organized/agents/ 2>/dev/null || true
mv hermes ~/organized/agents/ 2>/dev/null || true
mv oracle ~/organized/agents/ 2>/dev/null || true
mv guardian ~/organized/agents/ 2>/dev/null || true
mv skills ~/organized/agents/ 2>/dev/null || true
mv monitors ~/organized/agents/ 2>/dev/null || true
mv vectors ~/organized/agents/ 2>/dev/null || true
mv features ~/organized/agents/ 2>/dev/null || true
mv _misc ~/organized/agents/ 2>/dev/null || true

# ============================================================
# MCP
# ============================================================
mv aegentis-mcp ~/organized/mcp/ 2>/dev/null || true
mv aegentix-mcp ~/organized/mcp/ 2>/dev/null || true

# ============================================================
# INFRASTRUCTURE (Terraform, CloudFormation, main infra)
# ============================================================
mv main.tf ~/organized/infrastructure/terraform/ 2>/dev/null || true
mv main.py ~/organized/infrastructure/ 2>/dev/null || true
mv terraform ~/organized/infrastructure/terraform/ 2>/dev/null || true
mv modules ~/organized/infrastructure/terraform/ 2>/dev/null || true
mv _deployments ~/organized/infrastructure/ 2>/dev/null || true
mv _infra ~/organized/infrastructure/ 2>/dev/null || true
mv launch-aegentix-ec2.sh ~/organized/infrastructure/scripts/ 2>/dev/null || true
mv start-aegentix-business.sh ~/organized/infrastructure/scripts/ 2>/dev/null || true
mv start-aegentix-groves.sh ~/organized/infrastructure/scripts/ 2>/dev/null || true
mv verify-aegentix.sh ~/organized/infrastructure/scripts/ 2>/dev/null || true
mv eagle-shield-substrate ~/organized/infrastructure/ 2>/dev/null || true
mv aegentis-cloud-sync ~/organized/infrastructure/ 2>/dev/null || true

# ============================================================
# CONTAINERS (Docker, ECR, registries)
# ============================================================
mv docker-compose-nexus.yml ~/organized/containers/ 2>/dev/null || true
mv docker-compose.yml ~/organized/containers/ 2>/dev/null || true
mv nexus-data ~/organized/containers/ 2>/dev/null || true
mv nexus-registry ~/organized/containers/ 2>/dev/null || true
mv _registry ~/organized/containers/ 2>/dev/null || true

# ============================================================
# SECURITY
# ============================================================
mv aegentis-security-patch ~/organized/security/ 2>/dev/null || true
mv secure_patch ~/organized/security/ 2>/dev/null || true
mv _security ~/organized/security/ 2>/dev/null || true
mv shields ~/organized/security/ 2>/dev/null || true
mv aws-iam-security-inventory-20260707T181845Z ~/organized/security/ 2>/dev/null || true
mv aws-iam-security-inventory-20260707T181845Z.zip ~/organized/security/ 2>/dev/null || true
mv safe-iam-inventory.sh ~/organized/security/ 2>/dev/null || true

# ============================================================
# FINANCIAL
# ============================================================
mv aegentix_coinbase_activation ~/organized/financial/ 2>/dev/null || true
mv aegentix_coinbase_activation.zip ~/organized/financial/ 2>/dev/null || true
mv aegentix-coinbase-advtrade.zip ~/organized/financial/ 2>/dev/null || true
mv coinbase-readonly-key.json ~/organized/financial/ 2>/dev/null || true

# ============================================================
# LEGAL
# ============================================================
mv aegentis_legal_brain ~/organized/legal/ 2>/dev/null || true
mv legal-swarm.json ~/organized/legal/ 2>/dev/null || true
mv starship_law_core ~/organized/legal/ 2>/dev/null || true
mv LICENSE.txt ~/organized/legal/ 2>/dev/null || true

# ============================================================
# ORCHESTRATORS
# ============================================================
mv orchestrator.py ~/organized/orchestrators/ 2>/dev/null || true
mv orchestrator-test.json ~/organized/orchestrators/ 2>/dev/null || true
mv orchestrator.zip ~/organized/orchestrators/ 2>/dev/null || true
mv planner.py ~/organized/orchestrators/ 2>/dev/null || true
mv planner-test.json ~/organized/orchestrators/ 2>/dev/null || true
mv planner.zip ~/organized/orchestrators/ 2>/dev/null || true
mv plan.json ~/organized/orchestrators/ 2>/dev/null || true
mv nexus_enterprise.py ~/organized/orchestrators/ 2>/dev/null || true
mv nexus_mc.py ~/organized/orchestrators/ 2>/dev/null || true
mv nexus-exec.json ~/organized/orchestrators/ 2>/dev/null || true
mv nexus_enterprise ~/organized/orchestrators/ 2>/dev/null || true
mv starship_eternal ~/organized/orchestrators/ 2>/dev/null || true
mv starship_factory ~/organized/orchestrators/ 2>/dev/null || true
mv content ~/organized/orchestrators/ 2>/dev/null || true
mv domains ~/organized/orchestrators/ 2>/dev/null || true
mv orbits ~/organized/orchestrators/ 2>/dev/null || true

# ============================================================
# LAMBDAS
# ============================================================
mv lambda-pkg ~/organized/lambdas/ 2>/dev/null || true
mv _lambdas ~/organized/lambdas/ 2>/dev/null || true

# ============================================================
# LOGS
# ============================================================
mv ledger_A.log ~/organized/logs/ 2>/dev/null || true
mv ledger_C.log ~/organized/logs/ 2>/dev/null || true
mv cleanup_swarm.log ~/organized/logs/ 2>/dev/null || true
mv _logs ~/organized/logs/ 2>/dev/null || true

# ============================================================
# ARCHIVES / OLD DISTRIBUTIONS
# ============================================================
mv _archives ~/organized/archives/ 2>/dev/null || true
mv aegentix-nexus-distribute-20260705-215324 ~/organized/archives/ 2>/dev/null || true
mv aegentix-nexus-distribute-20260705-215634 ~/organized/archives/ 2>/dev/null || true
mv aegentix_cybercore_grove_orchards ~/organized/archives/ 2>/dev/null || true
mv aegentix_cybercore_grove_orchards.zip ~/organized/archives/ 2>/dev/null || true

# ============================================================
# LEDGER
# ============================================================
mv _ledger ~/organized/ledger/ 2>/dev/null || true
mv ledger ~/organized/ledger/ 2>/dev/null || true

# ============================================================
# RUNTIME
# ============================================================
mv _runtime ~/organized/runtime/ 2>/dev/null || true
mv runtime ~/organized/runtime/ 2>/dev/null || true
mv __pycache__ ~/organized/runtime/ 2>/dev/null || true

# ============================================================
# OSINT
# ============================================================
mv osint ~/organized/osint/ 2>/dev/null || true
mv worldmonitor ~/organized/osint/ 2>/dev/null || true

# ============================================================
# CONFIGS / MISC
# ============================================================
mv response.json ~/organized/configs/ 2>/dev/null || true
mv aegentix-key.pem ~/organized/configs/ 2>/dev/null || true
mv _report ~/organized/configs/ 2>/dev/null || true
mv _tests ~/organized/configs/ 2>/dev/null || true
mv _graph ~/organized/configs/ 2>/dev/null || true
mv tools ~/organized/configs/ 2>/dev/null || true
mv Desktop ~/organized/configs/ 2>/dev/null || true
mv bash ~/organized/configs/ 2>/dev/null || true
mv _deprecated ~/organized/archives/ 2>/dev/null || true

# ============================================================
# PROJECT PHASES
# ============================================================
mv phase2.yaml ~/organized/orchestrators/ 2>/dev/null || true
mv phase3 ~/organized/orchestrators/ 2>/dev/null || true
mv phase3-cosmic ~/organized/orchestrators/ 2>/dev/null || true
mv phase4-quantum ~/organized/orchestrators/ 2>/dev/null || true
mv phase5-transcendent ~/organized/orchestrators/ 2>/dev/null || true
mv phase6 ~/organized/orchestrators/ 2>/dev/null || true
mv phase6-omnipotent ~/organized/orchestrators/ 2>/dev/null || true

# ============================================================
# GEN, LABS, CYBERCORE
# ============================================================
mv gen01 ~/organized/core/ 2>/dev/null || true
mv gen02 ~/organized/core/ 2>/dev/null || true
mv gen03 ~/organized/core/ 2>/dev/null || true
mv labs ~/organized/core/ 2>/dev/null || true
mv kimitron ~/organized/core/ 2>/dev/null || true
mv cybercore ~/organized/core/ 2>/dev/null || true
mv brain ~/organized/core/ 2>/dev/null || true
mv manus-integration ~/organized/core/ 2>/dev/null || true
mv vault ~/organized/core/ 2>/dev/null || true
mv _vr ~/organized/core/ 2>/dev/null || true
mv dfir ~/organized/security/ 2>/dev/null || true

# ============================================================
# TRASH: obvious junk (literal command strings, stray flags, artifacts)
# ============================================================
mv '==="' ~/organized/trash/ 2>/dev/null || true
mv '-d' ~/organized/trash/ 2>/dev/null || true
mv '-H' ~/organized/trash/ 2>/dev/null || true
mv '-p' ~/organized/trash/ 2>/dev/null || true
mv 'a' ~/organized/trash/ 2>/dev/null || true
mv '--docker-password=' ~/organized/trash/ 2>/dev/null || true
mv '--docker-server=205718953513.dkr.ecr.us-west-1.amazonaws.com' ~/organized/trash/ 2>/dev/null || true
mv '--docker-username=AWS' ~/organized/trash/ 2>/dev/null || true
mv 'ec2 describe-instances --region us-west-1 --filters Name=instance-state-name,Values=running --query Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value|[0],InstanceType,State.Name] --output table' ~/organized/trash/ 2>/dev/null || true
mv 'ecs wait services-stable \' ~/organized/trash/ 2>/dev/null || true
mv "'-fixed-\$A-\$R\"'" ~/organized/trash/ 2>/dev/null || true
mv "'-multiversal-god (10240 MB) ✅\"'" ~/organized/trash/ 2>/dev/null || true
mv '-phase2.yaml' ~/organized/trash/ 2>/dev/null || true

# ============================================================
# GENERATE INDEX
# ============================================================
echo "[4/5] Generating index files..."

for dir in ~/organized/*/; do
    dirname=$(basename "$dir")
    echo "# $dirname" > "$dir/index.md"
    echo "" >> "$dir/index.md"
    echo "Contents of \`~/organized/$dirname/\`:" >> "$dir/index.md"
    echo "" >> "$dir/index.md"
    echo '```' >> "$dir/index.md"
    ls "$dir" >> "$dir/index.md"
    echo '```' >> "$dir/index.md"
done

# ============================================================
# MASTER INDEX
# ============================================================
echo "[5/5] Creating master index..."
cat > ~/organized/README.md << 'EOF'
# AEGENTIS CloudShell — Organized Directory

## Structure

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

## Date Organized
$(date)

## Original State Backup
$BACKUP_DIR/listing_before.txt
EOF

# --- Final report ---
echo ""
echo "============================================"
echo "  ORGANIZATION COMPLETE"
echo "============================================"
echo ""
echo "  New structure:  ~/organized/"
echo "  Backup listing: $BACKUP_DIR/listing_before.txt"
echo "  Master index:   ~/organized/README.md"
echo ""
echo "  Remaining items in ~ (not moved — may need review):"
echo "============================================"
ls -1 ~ | grep -v "^organized" || true
echo "============================================"
