#!/bin/bash

# Vulkan optimization script for Galaxy S23 (SM-S911B/DS)
# Requires: adb connected and authorized device

# Delay between commands (in seconds)
DELAY=1

echo "🔍 Checking connected device..."
DEVICE_MODEL=$(adb shell getprop ro.product.model | tr -d '\r')
DEVICE_NAME=$(adb shell getprop ro.product.device | tr -d '\r')

echo "📱 Detected model: $DEVICE_MODEL"
echo "📱 Device name: $DEVICE_NAME"

if [[ "$DEVICE_MODEL" == "SM-S911B" || "$DEVICE_MODEL" == *"Galaxy S23"* ]]; then
    echo "✅ Galaxy S23 detected. Applying Vulkan performance settings..."
    echo ""

    run_cmd() {
        CMD=$1
        echo "▶️ Running: $CMD"
        adb shell "$CMD"
        sleep $DELAY
        echo ""
    }

    # 1. Force Skia Pipeline with Vulkan
    run_cmd "setprop debug.hwui.renderer skiavk"
    run_cmd "setprop debug.hwui.skia_backend vk"

    # 2. Keep Vulkan active
    run_cmd "setprop debug.hwui.disable_vulkan 0"
    run_cmd "setprop debug.hwui.use_vulkan 1"

    # 3. Improve SurfaceFlinger performance
    run_cmd "setprop debug.sf.enable_gl_backpressure 1"

    # 4. Restart relevant system apps
    run_cmd "am crash com.android.systemui"
    run_cmd "am force-stop com.android.settings"
    run_cmd "am force-stop com.sec.android.app.launcher"
    run_cmd "am force-stop com.samsung.android.app.aodservice"

    # 5. Aggressive Vulkan backend
    run_cmd "setprop debug.renderengine.backend skiavk"

    echo "✅ All Vulkan performance commands executed."
else
    echo "❌ This device is not a Galaxy S23 (SM-S911B/DS). No changes applied."
fi
