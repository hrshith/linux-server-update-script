#!/bin/bash

# Update package lists
echo "Updating all packages"
sudo apt update
sleep 3
sudo apt upgrade -y

# Clean up old and unnecessary packages
echo "Removing unnecessary packages"
sudo apt autoremove -y

# Perform a distro upgrade but only with user acceptance to prevent any breaking changes from being applied
# "--simulate" command used here so no actual upgrade is performed before user prompt

dist_upgrade_available=$(sudo apt dist-upgrade --simulate | grep "upgraded, 0 newly installed")

if [[ -z $dist_upgrade_available ]]; then
    # Prompt the user for a distribution upgrade
    read -p "A distribution upgrade is available. Do you want to perform it? (y/n): " choice
    if [[ $choice =~ ^[Yy]$ ]]; then
        # Warn user and Perform distribution upgrade
        echo "Warning: Full system upgrade is starting and might take some time to complete"
        
        sudo apt dist-upgrade
    else
        echo "Skipping distribution upgrade."
    fi
else
    echo "No distribution upgrade available."
fi
