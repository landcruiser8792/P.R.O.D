#!/bin/bash

echo "Welcome to P.R.O.D — Plarium RAID on Distros"

xdg-open "https://plarium.com/referral-link-here"

if command -v docker &> /dev/null; then
    ENGINE="docker"
elif command -v podman &> /dev/null; then
    ENGINE="podman"
else
    echo "Docker or Podman not found. Attempting to install Docker..."
    if [ -f /etc/debian_version ]; then
        sudo apt update && sudo apt install -y docker.io
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y docker
    elif [ -f /etc/arch-release ]; then
        sudo pacman -Syu docker
    else
        echo "Unsupported distro. Please install Docker manually."
        exit 1
    fi
    ENGINE="docker"
fi

git clone https://github.com/landcruiser8792/P.R.O.D.git
cd P.R.O.D
$ENGINE build -t prod-plarium .
$ENGINE run -d --name prod-instance1 prod-plarium

echo "Plarium Play is now running in a container. Enjoy RAID!"
