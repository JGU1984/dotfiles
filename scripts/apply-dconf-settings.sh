#!/bin/bash
# Applies GNOME dconf settings.
# Runs once, and re-runs if gnome-settings.ini changes.

DCONF_FILE="$HOME/.config/dconf/gnome-settings.ini"

if ! command -v dconf &>/dev/null; then
    echo "dconf not found, skipping GNOME settings"
    exit 0
fi

echo "Applying GNOME dconf settings..."
dconf load / < "$DCONF_FILE"
echo "Done."
