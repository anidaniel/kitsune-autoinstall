#!/bin/bash
set -euo pipefail

# Log everything
exec > >(tee -a /var/log/kitsune-postinstall.log) 2>&1

echo "[INFO] Starting post-install setup..."

# Ensure Ansible is installed
if ! command -v ansible-playbook >/dev/null 2>&1; then
  apt-get update && apt-get install -y ansible
fi

# Prepare Ansible directory (assume it's already copied to /root/ansible)
if [ ! -d /root/ansible ]; then
  echo "[ERROR] /root/ansible not found. Aborting."
  exit 3
fi

# Run Ansible provisioning
chmod +x /root/run-ansible.sh
/root/run-ansible.sh
# scripts/setup-postinstall.sh

(Placeholder content for scripts/setup-postinstall.sh)