# Miscellaneous Linux Tweaks
A collection of small Linux tweaks, scripts, and utilities I have made over the years.<br>
Most tweaks come with an `install.sh` or a README.<br>
Enable all scripts (should not be necessary):
```
chmod +x */*.sh
```
## DuckDuckGo Catppuccin Mocha Kinda (Not linux specific)
A userstyle for duckduckgo.com based on a slightly more saturated Catppuccin Mocha.
## My fastfetch Config
Default except for circle symbol for colors
## My Fish Prompt
Just a simple fish prompt I made for myself. It has some abstraction which can be used to add and customize elements.
![Preview image](my-fish-prompt/assets/image.png)
## Universal GPU Offload
Attempts to offload the GPU in as many cases as possible. It should work for X11, Wayland, EGL, GLX, Vulkan, Nvidia, AMD, and/or Mesa. Run with `ugo %command%` after installing with `install.sh`.<br>`ugo2` gives you four levels.<br>Usage:
```
ugo2 <0-4> command
0 - no-op: runs command with no vars set (baseline/control)
1 - GLX + EGL-X11 + Vulkan offload (routing only, no device hiding)
2 - adds native-Wayland coverage (GBM) - risk: can crash on some compositors
3 - adds implicit-layer device hiding - risk: apps CAN opt out (e.g. Blender)
4 - adds loader-level ICD restriction - apps can't opt out; also removes software/lavapipe fallback for anything else in the process
```
<br>
Card defaults to nvidia, use `DGPU_CARD=amd ugo2 <0-4> command` for AMD cards (and intel?)
