# NeKoRoSYS's Arch Dotfiles
Based on [mkhmtolzhas' rice](https://github.com/mkhmtolzhas/Invincible-Dots).


## Features
- One-tap installer script
  - use `git clone https://github.com/NeKoRoSYS/NeKoRoSYS-Arch-Dotfiles`
  - then `cd NeKoRoSYS-Arch-Dotfiles`
  - and finally, `bash install.sh` to install the dotfiles.
- Advanced wallpaper handling
  - Supports both image (via swww) and video (via mpvpaper) formats
    - mpvpaper automatically stops if an app is on fullscreen mode to save CPU, RAM, or GPU space
  - Border colors and UI elements have dynamic color schemes
- Familiar waybar setup
  - Sleek and straightforward design
  - Built to feel like a windows taskbar
    - Choose to start an app, change workspaces, or select power options like Lock, Sleep, Shut Down, Reboot, and Sign Out


## Notes
- The installer assumes you already installed `base-devel`, `git`, `yay`, `flatpak`.
- The installer assumes you have turned on mirror link downloads for `pacman`.
- Don't be scared if sed says it can't read a file or directory in the installer. It's part of the function to replace every occurence of `/home/nekorosys` with your username and it simply cant find one at those locations.
- You can freely customize `flatpak.txt` and `pkglist.txt`
- **IMPORTANT** This rice originally uses my dual-monitor setup. Enter `grep -r "DP-1" ~/.config/` and `grep -r "eDP-1" ~/.config/` to find all occurences of my monitors being mentioned so you can replace them with your own.
  - `start-dashboard.sh` creates a grid layout for a 1920x1080 display, it may not work the same for you if your monitor has a different resolution.


## Dependencies
- Auto-stop animated wallpapers https://github.com/pvtoari/mpvpaper-stop (dependencies: cmake, cjson)
  - Used at `set-wallpaper.sh` and `check-video.sh` in `~/.config/hypr/scripts/wallpapers/` to save CPU/RAM usage.
- The waybar was set up to use kitty, Mozilla Firefox, and dolphin. You can change this if you want at `~/.config/waybar/config.jsonc`.
