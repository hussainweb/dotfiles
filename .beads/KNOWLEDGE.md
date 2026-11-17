# Area Knowledge

## 1Password CLI & macOS TCC (Rex vs Herdr)

*2026-11-17*

- On macOS, `op` connects to `1Password.app` desktop integration by reading `~/Library/Group Containers/2BUA8C4S2C.com.1password/Library/Application Support/1Password/Data/settings/settings.json`.
- macOS TCC blocks processes without permission from reading another app's Group Container (`operation not permitted`). When blocked, `op` skips desktop app integration and silently falls back to `~/.config/op/config`, returning `[]` for `op account list` (which triggers `.install-1password.sh` to prompt for manual account setup).
- **Diagnosis:** Run `op --debug account list` to see `Skipped loading desktop app settings file ... operation not permitted`.
- **Fix for Rex:** Grant `Rex Server.app` (`~/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app`) access in **System Settings → Privacy & Security → Full Disk Access** (or the macOS app-data access prompt, which is how Herdr gets access without appearing in Full Disk Access).
