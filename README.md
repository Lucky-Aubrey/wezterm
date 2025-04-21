# 🧙 WezTerm Configuration

This is a custom configuration for WezTerm – a GPU-accelerated terminal emulator and multiplexer.

It includes a minimal UI, JetBrains Mono font, transparent window background, and extensive keybindings for pane and tab management using a `CTRL+a` leader key.
![Wezterm with NeoVim](/images/screenshot.png)
***

## ⚙ Features

🎨 **Color Scheme**: Tokyo Night, Cyberdream

🔠 **Font**: JetBrains Mono

🪟 **Decorations**: Resizable borders only

🔳 **Padding**: 0px on all sides

💻 **Shell**: PowerShell7 (pswh.exe)

🫧 **Opacity**: Shortcut for toggling between 1.0, 0.8, 0.3, 0.1

⌨️ **Leader Key**: `CTRL+a`

🔄 Tab & Pane Management: Vim-style navigation and controls

***

## ⌨️ Keybindings

All keybindings are triggered after pressing `CTRL+a` (Leader key):

|**Key**| **Action**|
|:---:|:---:|
|[| Copy Mode|
|v| Split pane **horizontally**|
|s| Split pane **vertically**|
|q| Close current pane (with confirm)|
|t| Open a **new tab**|
|n| Next tab|
|p| Previous tab|
|h| Move focus **left**|
|l| Move focus **right**|
|k| Move focus **up**|
|j| Move focus **down**|
|o| Rotate panes counter-clockwise|
|O| Rotate panes clockwise|
|r| Resize pane with `hjkl`|
|e| Show Tab Navigator|
|c| Rename Tab|
|1-9| Switch to tab number (1–8)|
|b| Cycle between opacity levels|

📝 **Example: Press `CTRL+a` then `v` to split the pane horizontally.**

***


## 📁 File: wezterm.lua

Place this configuration in your ~/.wezterm.lua or ~/.config/wezterm/wezterm.lua.

## Comments
* In my opinion Tokyo Night works better with opaque or little transparent background
* Cyberdream works best with transparent background and nice wallpapers. E.g. darker themes. However, sometimes it is too distracting which is why I added a toggle key for the background opacity.

### History
The configurations of my Wezterm setup is heavily influenced by a youtuber (forgot name sry) whose wezterm config I took as baseline. I adjusted a lot of keybindings too be more similar to standard tmux keybindings (still in progress). I mainly use Ubuntu for coding tasks. However, I had fun trying to make a NeoVim-Setup work on windows, which is why I ended up with some wezterm settings for powershell.
