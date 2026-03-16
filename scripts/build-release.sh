#!/bin/bash
set -euo pipefail

APP_NAME="SnapMyWindows"
BUILD_DIR="build"
ARCHIVE_PATH="${BUILD_DIR}/${APP_NAME}.xcarchive"
APP_PATH="${BUILD_DIR}/${APP_NAME}.app"
DMG_PATH="${BUILD_DIR}/${APP_NAME}.dmg"

# Build mode: "dmg" (default, for GitHub distribution) or "appstore"
MODE="${1:-dmg}"

echo "==> Cleaning build directory..."
rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

echo "==> Generating Xcode project..."
xcodegen generate

echo "==> Building release archive..."
xcodebuild archive \
    -project "${APP_NAME}.xcodeproj" \
    -scheme "${APP_NAME}" \
    -configuration Release \
    -archivePath "${ARCHIVE_PATH}" \
    | tail -5

if [ "$MODE" = "appstore" ]; then
    echo "==> Exporting for App Store..."
    cat > "${BUILD_DIR}/ExportOptions.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>destination</key>
    <string>upload</string>
</dict>
</plist>
PLIST

    xcodebuild -exportArchive \
        -archivePath "${ARCHIVE_PATH}" \
        -exportOptionsPlist "${BUILD_DIR}/ExportOptions.plist" \
        -exportPath "${BUILD_DIR}/AppStore"

    echo ""
    echo "==> Done! App Store package exported to: ${BUILD_DIR}/AppStore/"
    echo "    You can also use Xcode Organizer: open ${ARCHIVE_PATH}"
else
    echo "==> Exporting app bundle..."
    cp -R "${ARCHIVE_PATH}/Products/Applications/${APP_NAME}.app" "${APP_PATH}"

    echo "==> Creating DMG..."
    hdiutil create -volname "${APP_NAME}" \
        -srcfolder "${APP_PATH}" \
        -ov -format UDZO \
        "${DMG_PATH}"

    echo ""
    echo "==> Done!"
    echo "    App: ${APP_PATH}"
    echo "    DMG: ${DMG_PATH}"
fi
