# Setup Scripts

This directory contains utility scripts for setting up a new system.

**Important:** These scripts are version-controlled but **NOT automatically deployed** by chezmoi. They must be run manually after the bootstrap process.

## Quick Reference

If you used the **[bootstrap script](https://github.com/JGU1984/bootstrap-new-ubuntu)** (recommended), it already:
- ✅ Installed all system packages
- ✅ Installed chezmoi
- ✅ Applied all dotfiles from this repository

**After bootstrap completes**, run these scripts manually as needed.

## Available Scripts

### apply-dconf-settings.sh

Applies GNOME dconf settings from `~/.config/dconf/gnome-settings.ini`.

**Usage:**
```bash
bash ~/.local/share/chezmoi/scripts/apply-dconf-settings.sh
```

**When to run:**
- After the bootstrap script completes (for Ubuntu Desktop with GNOME)
- After manually running `chezmoi apply` on a new installation
- When you want to restore your GNOME settings

**What it does:**
- Checks if `dconf` command is available
- Loads settings from `~/.config/dconf/gnome-settings.ini` into the GNOME dconf database
- Applies your desktop customizations (theme, keybindings, extensions, etc.)

**Note:** This script is safe to run multiple times. It will overwrite current GNOME settings with the ones from the config file.

## Why Manual Scripts?

These scripts are kept in the chezmoi source for version control and portability, but are executed manually rather than automatically because:

1. **Reliability** - Manual execution gives you control over when and how scripts run
2. **Transparency** - You know exactly what's being executed
3. **Flexibility** - Easy to modify or skip scripts as needed
4. **Compatibility** - Works with any chezmoi version

## Adding New Scripts

To add a new setup script:

1. Create the script in this directory:
   ```bash
   nano ~/.local/share/chezmoi/scripts/your-script.sh
   ```

2. Make it executable:
   ```bash
   chmod +x ~/.local/share/chezmoi/scripts/your-script.sh
   ```

3. Document it in this README

4. The `scripts/` directory is already ignored in `.chezmoignore`, so it won't be deployed

## Updating GNOME Settings

To update the GNOME settings backup on your main machine:

```bash
# Dump current settings
dconf dump / > ~/.local/share/chezmoi/private_dot_config/private_dconf/gnome-settings.ini

# Review changes
cd ~/.local/share/chezmoi
git diff private_dot_config/private_dconf/gnome-settings.ini

# Commit if you like the changes
git add private_dot_config/private_dconf/gnome-settings.ini
git commit -m "Update GNOME settings backup"
git push
```
