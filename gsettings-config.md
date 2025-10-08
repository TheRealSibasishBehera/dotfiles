# GNOME Settings Configuration Log

This file tracks all gsettings commands used to configure this system.

## Keyboard Remapping

### Current Mapping (Applied 2025-10-09)

**Keys remapped (3-way rotation of modifiers, both left and right sides):**
- **Caps Lock** → **Escape**
- **Ctrl** → **Super/Win** → **Alt** → **Ctrl** (circular rotation)

**Net effect on ALL modifier keys:**
- Physical **Caps Lock** = **Escape**
- Physical **Ctrl** (left/right) = **Super/Win key**
- Physical **Super/Win** (left/right) = **Alt**
- Physical **Alt** (left/right) = **Ctrl**

**Command:**
```bash
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape', 'altwin:ctrl_alt_win']"
```

**Verify:**
```bash
gsettings get org.gnome.desktop.input-sources xkb-options
```

**Status:** ✅ Applied on 2025-10-09

### Activities/Search Shortcut

**Changed from:** Super key (single press)
**Changed to:** Super + Space

**Commands:**
```bash
# Disable Super key overlay
gsettings set org.gnome.mutter overlay-key ''

# Set Super+Space for Activities overview
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>space']"

# Set Super+Space for application view
gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>space']"

# Set Super+Space for panel main menu
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "['<Super>space']"
```

**Status:** ✅ Applied on 2025-10-09

---

## How to Apply All Settings

To apply all settings on a new machine, run:
```bash
# Keyboard remapping (3-way rotation on both left and right sides)
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape', 'altwin:ctrl_alt_win']"

# Activities shortcut (Super+Space instead of just Super)
gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>space']"
gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>space']"
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "['<Super>space']"
```

## Available XKB Options for Keyboard Remapping

Common options you can add to the array:
- `caps:escape` - Caps Lock as Escape
- `caps:ctrl_modifier` - Caps Lock as Ctrl
- `ctrl:swap_lalt_lctl` - Swap left Alt and left Ctrl
- `ctrl:swap_lwin_lctl` - Swap left Super/Win and left Ctrl
- `altwin:swap_alt_win` - Swap Alt and Super/Win
- `compose:ralt` - Right Alt as Compose key

Example with multiple options:
```bash
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape', 'compose:ralt']"
```
