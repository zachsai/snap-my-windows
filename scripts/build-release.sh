#!/bin/bash
set -euo pipefail

APP_NAME="SnapMyWindows"
BUILD_DIR="build"
ARCHIVE_PATH="${BUILD_DIR}/${APP_NAME}.xcarchive"
APP_PATH="${BUILD_DIR}/${APP_NAME}.app"
DMG_PATH="${BUILD_DIR}/${APP_NAME}.dmg"

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
    CODE_SIGN_IDENTITY="-" \
    ENABLE_APP_SANDBOX=NO \
    | tail -5

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
