@echo off
:: ------------------------------------------------------------
:: Vulkan Optimization Script for Galaxy S23 (SM-S911B/DS)
:: Works on Windows - requires adb in PATH
:: ------------------------------------------------------------

setlocal enabledelayedexpansion
set DELAY=1

echo 🔍 Checking connected device...
for /f "usebackq delims=" %%A in (`adb shell getprop ro.product.model`) do set MODEL=%%A
for /f "usebackq delims=" %%A in (`adb shell getprop ro.product.device`) do set DEVICE=%%A

echo 📱 Detected model: %MODEL%
echo 📱 Device name: %DEVICE%
echo.

if "%MODEL%"=="SM-S911B/DS" (
    echo ✅ Galaxy S23 detected. Applying Vulkan performance settings...
) else (
    echo ❌ This device is not a Galaxy S23 (SM-S911B/DS). No changes applied.
    goto :end
)
echo.

:: Helper function to run commands sequentially
call :run_cmd "setprop debug.hwui.renderer skiavk"
call :run_cmd "setprop debug.hwui.skia_backend vk"

call :run_cmd "setprop debug.hwui.disable_vulkan 0"
call :run_cmd "setprop debug.hwui.use_vulkan 1"

call :run_cmd "setprop debug.sf.enable_gl_backpressure 1"

call :run_cmd "am crash com.android.systemui"
call :run_cmd "am force-stop com.android.settings"
call :run_cmd "am force-stop com.sec.android.app.launcher"
call :run_cmd "am force-stop com.samsung.android.app.aodservice"

call :run_cmd "setprop debug.renderengine.backend skiavk"

echo ✅ All Vulkan performance commands executed successfully.
goto :end

:: -------------------------------
:: Helper function definition
:: -------------------------------
:run_cmd
echo ▶️ Running: %~1
adb shell %~1
timeout /t %DELAY% >nul
echo.
exit /b

:end
echo.
echo ⚙️ Done.
endlocal
pause

