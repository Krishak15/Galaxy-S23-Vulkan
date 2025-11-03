# ⚡ Enable Vulkan Rendering on Galaxy S23 (SM-S911B/DS)

This repository provides ready-to-use scripts to **force-enable Vulkan and Skia rendering** on Samsung Galaxy S23 devices.  
The scripts configure Android’s rendering system for improved graphics performance and lower latency using **Vulkan**, the modern GPU API.

> ⚠️ **Note:**  
> These tweaks are meant for **developers and power users**.  
> They are **temporary** (reset after reboot) and may not behave the same on every firmware.  
> Use responsibly & at your own risk.

---

## 🧠 What These Scripts Do

The scripts apply a set of system properties (`setprop`) and restart key Android components to:
- **Force-enable Vulkan rendering** instead of OpenGL ES.
- **Use the Skia graphics engine with Vulkan backend** for all UI rendering.
- **Prevent fallback** to software or OpenGL rendering.
- **Reduce composition latency** in SurfaceFlinger (Android’s display compositor).
- **Restart system UI and launcher** to apply the changes without rebooting.

In simpler terms:
> 🌀 They make your Galaxy S23 use **Vulkan everywhere** for drawing, animations, and compositing — potentially making the system feel smoother and more responsive.

---

## 🧩 Requirements

Before running either script:

1. **Device:** Samsung Galaxy S23 (`SM-S911B/DS`) or a compatible model.
2. **ADB (Android Debug Bridge)** installed on your computer.
   - **macOS/Linux:**  
     Install with Homebrew → `brew install android-platform-tools`
   - **Windows:**  
     [Download platform-tools from Google](https://developer.android.com/studio/releases/platform-tools)
3. **Enable Developer Options** → **USB Debugging** on your phone.
4. **Connect your phone** via USB and authorize the computer.

---

## 🖥️ macOS / Linux

### File: `enable_vulkan_s23.sh`

### Steps:
1. Connect your phone with USB debugging enabled.
2. Open Terminal in the folder containing the script.
3. Make the script executable:
   
   ```bash
   chmod +x enable_vulkan_s23.sh
4. Run
   
    ```bash
   enable_vulkan_s23.sh

## Windows

### File: `enable_vulkan_s23.bat`

### Steps:
1. Connect your phone with USB debugging enabled.
2. Open Command Prompt in the folder containing the .bat file.
Run:

   ```bash
   enable_vulkan_s23.bat

> Note: Reboot will reset this changes. Apply each time you reboot.
