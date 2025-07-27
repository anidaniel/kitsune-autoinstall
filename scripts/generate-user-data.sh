#!/bin/bash
set -euo pipefail

# Load .env variables
if [ -f ../.env ]; then
  set -a
  source ../.env
  set +a
elif [ -f .env ]; then
  set -a
  source .env
  set +a
else
  echo "[ERROR] .env file not found!"
  exit 1
fi

# Generate user-data from template
if [ ! -f ../autoinstall/user-data.template ]; then
  echo "[ERROR] user-data.template not found!"
  exit 2
fi

envsubst < ../autoinstall/user-data.template > ../autoinstall/user-data

chmod 600 ../autoinstall/user-data

echo "[INFO] user-data generated successfully."
