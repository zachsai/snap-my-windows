#!/bin/bash
# Kill running instance and relaunch from DerivedData
APP_NAME="SnapMyWindows"
# Pick the build with the most recently modified binary
DERIVED_APP=$(ls -t ~/Library/Developer/Xcode/DerivedData/${APP_NAME}-*/Build/Products/Debug/${APP_NAME}.app/Contents/MacOS/${APP_NAME} 2>/dev/null | head -1 | sed 's|/Contents/MacOS/.*||')

if [ -z "$DERIVED_APP" ]; then
    echo "No debug build found. Run a build first."
    exit 1
fi

pkill -x "$APP_NAME" 2>/dev/null && sleep 0.5
open "$DERIVED_APP"
echo "Launched $DERIVED_APP"
