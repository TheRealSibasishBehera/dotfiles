# Keyboard Maestro Configuration

## Mouse to Monitor Macros

Quickly move your mouse pointer to different monitors using keyboard shortcuts.

### Shortcuts

- `⌃⌘1` (Control + Command + 1) → Move mouse to Monitor 1
- `⌃⌘2` (Control + Command + 2) → Move mouse to Monitor 2
- `⌃⌘3` (Control + Command + 3) → Move mouse to Monitor 3

### Installation

Import the macros:
```bash
open Mouse-to-Monitor.kmmacros
```

### Customization

To customize the shortcuts or behavior:

1. Open Keyboard Maestro Editor
2. Find the "Mouse to Monitor" macro group
3. Edit individual macros to:
   - Change keyboard shortcuts
   - Adjust mouse position (currently set to center of screen)
   - Add more monitors
   - Change to specific coordinates instead of center

### Monitor Numbering

Monitor 0 = Main display (usually your primary monitor)
Monitor 1 = Second display
Monitor 2 = Third display

The numbering follows macOS display arrangement in System Settings → Displays.
