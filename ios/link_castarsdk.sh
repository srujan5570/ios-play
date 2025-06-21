#!/bin/bash

# Script to link CastarSDK framework in Xcode project

FRAMEWORK_PATH="$(pwd)/CastarSDK.framework"
PROJECT_PATH="$(pwd)/Runner.xcodeproj"
TARGET_NAME="Runner"

echo "Linking CastarSDK framework..."
echo "Framework path: $FRAMEWORK_PATH"
echo "Project path: $PROJECT_PATH"

# Check if framework exists
if [ ! -d "$FRAMEWORK_PATH" ]; then
    echo "Error: CastarSDK.framework not found at $FRAMEWORK_PATH"
    exit 1
fi

# Add framework to project using xcodebuild
xcodebuild -project "$PROJECT_PATH" -target "$TARGET_NAME" -configuration Release FRAMEWORK_SEARCH_PATHS="$(pwd)" OTHER_LDFLAGS="-framework CastarSDK"

echo "CastarSDK framework linked successfully!" 