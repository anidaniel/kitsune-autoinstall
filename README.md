# Kitsune Autoinstall: Professional Automated Ubuntu 24.04 LTS Server Installer

This project delivers a fully headless, Wi-Fi-only, zero-touch Ubuntu 24.04 LTS installation for Dell XPS 13 (or VM), using cloud-init and Ansible. It automates everything from USB boot to a production-ready, secure, and monitored server.

---

## Phase Breakdown

**Phase 0 – Prepare Bootable USB**
- Generate a `cidata` ISO with `autoinstall/meta-data` and `autoinstall/user-data`.
- Write ISO to USB and boot the target machine.

**Phase 1 – Fully Unattended Installation**
- Ubuntu autoinstall with:
  - Wi-Fi setup (`WIFI_NAME`, `PASSWORD-123`)
  - Custom user: `anidaniel`, hostname: `kitsune`
  - Static IP: `192.168.1.99/24`
  - LUKS full-disk encryption
  - Hardened SSH (port 3624, key-only)
  - Ansible installed in late-commands

**Phase 2 – Automatic Ansible Provisioning**
- On first boot, Ansible playbook runs automatically:
  - `common`: updates, timezone, essential packages
  - `docker`: Docker Engine + Compose
  - `netdata`: monitoring
  - `ssh_hardening`: custom port, root login disabled, etc.
  - `networking`: static IP, DNS, Wi-Fi
- Self-healing: logs, auto-rollback, retry on failure

**Phase 3 – Optional Post-Deploy Testing**
- Local/remote validation scripts
- Health checks, service status, and connectivity

---

## Quick Start

1. **Customize** `autoinstall/user-data` and `autoinstall/meta-data` as needed (replace `<YOUR_SSH_PUBLIC_KEY>` and password hash).
2. **Create USB**:
   ```bash
   genisoimage -output cidata.iso -volid cidata -joliet -rock autoinstall/meta-data autoinstall/user-data
   sudo dd if=cidata.iso of=/dev/sdX bs=4M status=progress
   ```
3. **Boot** target machine from USB.
4. **Let the installer run unattended.**
5. **Ansible will auto-provision on first boot.**

---

## Directory Structure

```
kitsune-autoinstall/
├── ansible
│   ├── inventory
│   ├── playbook.yml
│   ├── roles
│   │   ├── common
│   │   │   └── tasks/main.yml
│   │   ├── docker
│   │   │   └── tasks/main.yml
│   │   ├── netdata
│   │   │   └── tasks/main.yml
│   │   ├── networking
│   │   │   └── tasks/main.yml
│   │   └── ssh_hardening
│   │       └── tasks/main.yml
│   └── setup-playbook.yml
├── autoinstall
│   ├── meta-data
│   └── user-data
├── meta-data
├── README.md
├── scripts
│   ├── run-ansible.sh
│   └── setup-postinstall.sh
└── user-data
```

---

## Security Notes
- SSH is key-only, custom port, root login disabled.
- LUKS full-disk encryption is enabled.
- All credentials and keys should be replaced with your own.

---

## Innovation & Features
- Modular, idempotent Ansible roles for easy extension
- Self-healing: logs, auto-rollback, retry on failure
- Designed for both VM and bare-metal (Dell XPS 13)
- Wi-Fi-only, no Ethernet required
- Hardened out-of-the-box

---

## Credits
- Inspired by Ubuntu Autoinstall, Ansible best practices, and the open-source community.
