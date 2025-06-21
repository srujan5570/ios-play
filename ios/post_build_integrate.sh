#!/bin/bash

# Post-build CastarSDK Integration Script
# This script integrates CastarSDK after Flutter build completes

set -e

echo "🔧 Starting post-build CastarSDK integration..."

# Check if CastarSDK.framework exists
if [ ! -d "CastarSDK.framework" ]; then
    echo "❌ CastarSDK.framework not found in ios directory"
    exit 1
fi

# Create Frameworks directory if it doesn't exist
mkdir -p "Runner/Frameworks"

# Copy CastarSDK.framework to the app bundle
echo "📦 Copying CastarSDK.framework to app bundle..."
cp -R "CastarSDK.framework" "Runner/Frameworks/"

# Update Info.plist to include framework
echo "📝 Updating Info.plist..."
if ! grep -q "CastarSDK.framework" "Runner/Info.plist"; then
    # Add framework to Info.plist
    sed -i '' '/<key>CFBundleExecutables<\/key>/a\
    <key>CFBundleFrameworks</key>\
    <array>\
        <string>CastarSDK.framework</string>\
    </array>' "Runner/Info.plist"
fi

echo "✅ CastarSDK integration completed successfully!"
echo "📱 App is ready for distribution with CastarSDK" 