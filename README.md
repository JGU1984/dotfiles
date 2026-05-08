# dotfiles

Dotfiles repository managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

### On a New Ubuntu Installation (Recommended)

**Use the automated bootstrap script** from [`JGU1984/bootstrap-new-ubuntu`](https://github.com/JGU1984/bootstrap-new-ubuntu):

```bash
# Day-zero setup:
sudo apt update && sudo apt install -y git

# Retrieve SSH key from NordPass and place it:
mkdir -p ~/.ssh && chmod 700 ~/.ssh
# paste key into ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519

# Clone and run bootstrap script:
git clone https://github.com/JGU1984/bootstrap-new-ubuntu.git
cd bootstrap-new-ubuntu
./bootstrap_new_ubuntu.sh

# Log out and back in (Zsh and Docker group membership)
```

**What the bootstrap script does:**
1. Installs Ansible and runs system package installation
2. Installs development tools (Docker, Chrome, Spotify, Kitty, Slack, JetBrains Toolbox, SDKMAN, etc.)
3. Sets Zsh as default shell
4. Installs chezmoi and automatically applies this dotfiles repository
5. Sets up complete development environment

**After bootstrap completes:**
```bash
# Apply GNOME dconf settings (if on Ubuntu Desktop)
bash ~/.local/share/chezmoi/scripts/apply-dconf-settings.sh
```

### Manual Chezmoi Installation (Alternative)

If you only want to install dotfiles without the full bootstrap:

1. **Install chezmoi:**
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. **Initialize and apply dotfiles:**
   ```bash
   chezmoi init --apply git@github.com:JGU1984/dotfiles.git
   ```

3. **Run manual setup scripts:**
   ```bash
   # Apply GNOME dconf settings
   bash ~/.local/share/chezmoi/scripts/apply-dconf-settings.sh
   ```

### On Your Existing Machine (lenovoLinux)

To update dotfiles:
```bash
# Check status
chezmoi status

# Apply changes
chezmoi apply

# Update source from home directory
chezmoi add <file>
```

## Directory Structure

- **`scripts/`** - Manual setup scripts for new installations (not auto-deployed)
- **`private_dot_config/`** - Configuration files for `~/.config/`
- **`.chezmoignore`** - Files to ignore on specific machines

## Important Notes

### GNOME Settings

- **`private_dot_config/private_dconf/gnome-settings.ini`** - Contains GNOME dconf settings
  - Ignored on `lenovoLinux` (your main machine)
  - Deployed on new installations
  - Apply manually using `scripts/apply-dconf-settings.sh` after running `chezmoi apply`

### Scripts Directory

The `scripts/` directory contains utility scripts that are:
- Version-controlled in this repository
- NOT automatically deployed by chezmoi (excluded in `.chezmoignore`)
- Meant to be run manually after `chezmoi apply` on new installations

See `scripts/README.md` for details on available scripts.

## Workflow

### Adding a New File to Chezmoi

```bash
chezmoi add ~/.config/example.conf
```

### Editing a Managed File

```bash
chezmoi edit ~/.bashrc
# or edit directly in the source:
nano ~/.local/share/chezmoi/dot_bashrc
```

### Updating GNOME Settings Backup

On your main machine (lenovoLinux), when you want to update the GNOME settings backup:

```bash
# Dump current GNOME settings
dconf dump / > ~/.local/share/chezmoi/private_dot_config/private_dconf/gnome-settings.ini

# Review and commit changes
cd ~/.local/share/chezmoi
git diff
git add private_dot_config/private_dconf/gnome-settings.ini
git commit -m "Update GNOME settings"
git push
```

## Troubleshooting

### Chezmoi Status Shows Unexpected Files

- Check `.chezmoignore` for conditional ignores based on hostname
- Current hostname: `lenovoLinux`
- Files ignored on this machine: `gnome-settings.ini`

### Reset Chezmoi State

If chezmoi's state gets corrupted:
```bash
chezmoi state reset
``` 
