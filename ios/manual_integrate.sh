#!/bin/bash

# Manual CastarSDK Integration Script
# Run this after building your Flutter app to integrate CastarSDK

set -e

echo "🔧 Manual CastarSDK Integration Script"
echo "======================================"

# Check if we're in the right directory
if [ ! -d "Runner" ]; then
    echo "❌ Error: Runner directory not found. Please run this script from the ios directory after building."
    exit 1
fi

# Check if CastarSDK.framework exists
if [ ! -d "CastarSDK.framework" ]; then
    echo "❌ Error: CastarSDK.framework not found in current directory"
    echo "Please ensure CastarSDK.framework is in the ios directory"
    exit 1
fi

echo "📦 Found CastarSDK.framework, starting integration..."

# Create Frameworks directory in the app bundle
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
    echo "✅ Added CastarSDK.framework to Info.plist"
else
    echo "ℹ️  CastarSDK.framework already in Info.plist"
fi

# Verify integration
echo "🔍 Verifying integration..."
if [ -d "Runner/Frameworks/CastarSDK.framework" ]; then
    echo "✅ CastarSDK.framework successfully copied to app bundle"
else
    echo "❌ Failed to copy CastarSDK.framework"
    exit 1
fi

echo ""
echo "🎉 CastarSDK integration completed successfully!"
echo "📱 Your app is now ready with CastarSDK integrated"
echo ""
echo "Next steps:"
echo "1. Test the app on a device"
echo "2. Verify CastarSDK initialization in AppDelegate.swift"
echo "3. Archive and distribute your app" 