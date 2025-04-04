# 🧙 WezTerm Configuration

This is a custom configuration for WezTerm – a GPU-accelerated terminal emulator and multiplexer.

It includes a minimal UI, JetBrains Mono font, transparent window background, and extensive keybindings for pane and tab management using a `CTRL+a` leader key.
![Wezterm with NeoVim](/images/screenshot.png)
***

## ⚙ Features

🎨 **Color Scheme**: Tokyo Night

🔠 **Font**: JetBrains Mono

🪟 **Decorations**: Resizable borders only

🔳 **Padding**: 0px on all sides

💻 **Shell**: PowerShell (powershell.exe)

🫧 **Opacity**: 80% background transparency

⌨️ **Leader Key**: `CTRL+a`

🔄 Tab & Pane Management: Vim-style navigation and controls

***

## ⌨️ Keybindings

All keybindings are triggered after pressing `CTRL+a` (Leader key):

|**Key**| **Action**|
|:---:|:---:|
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
|r| Rotate panes counter-clockwise|
|R| Rotate panes clockwise|
|1-8| Switch to tab number (1–8)|

📝 **Example: Press `CTRL+a` then `v` to split the pane horizontally.**

***

## 🧼 Skip Close Confirmation

Closing the last pane doesn't ask for confirmation if running one of the following:

    bash, sh, zsh, fish, tmux, nu, cmd.exe, pwsh.exe, powershell.exe

***

## 📁 File: wezterm.lua

Place this configuration in your ~/.wezterm.lua or the appropriate config location for your OS.
