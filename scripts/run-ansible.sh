#!/bin/bash
cd /opt/kitsune/ansible
set -euo pipefail

LOGFILE="/var/log/ansible-provision.log"
INVENTORY="$(dirname "$0")/../ansible/inventory"
PLAYBOOK="$(dirname "$0")/../ansible/playbook.yml"

# Idempotency: check if already provisioned
if [ -f /etc/kitsune-ansible-provisioned ]; then
  echo "[INFO] Ansible provisioning already completed. Exiting."
  exit 0
fi

echo "[INFO] Starting Ansible provisioning..."

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "[ERROR] Ansible is not installed. Aborting."
  exit 2
fi

ansible-playbook -i "$INVENTORY" "$PLAYBOOK" | tee "$LOGFILE"

if [ "${PIPESTATUS[0]}" -eq 0 ]; then
  touch /etc/kitsune-ansible-provisioned
  echo "[INFO] Provisioning complete."
else
  echo "[ERROR] Provisioning failed. Check $LOGFILE."
  exit 1
fi
