# CastarSDK Integration Guide

This document explains how to integrate CastarSDK into your Flutter iOS app using post-build integration methods.

## Overview

CastarSDK is integrated after the Flutter build completes, avoiding build-time linking issues. This approach is more reliable and works consistently across different build environments.

## Integration Methods

### 1. Automated CI/CD Integration (Recommended)

The GitHub Actions workflow automatically integrates CastarSDK after building:

1. **Build Process**: Flutter builds the app without CastarSDK
2. **Post-Build Script**: `post_build_integrate.sh` runs automatically
3. **Framework Integration**: CastarSDK.framework is copied to the app bundle
4. **Info.plist Update**: Framework is registered in the app's Info.plist

### 2. Manual Local Integration

If you need to integrate locally after building:

```bash
# Navigate to ios directory
cd ios

# Make the script executable
chmod +x manual_integrate.sh

# Run the integration script
./manual_integrate.sh
```

### 3. Manual Steps (if scripts fail)

If the automated scripts don't work, you can integrate manually:

1. **Copy Framework**:
   ```bash
   mkdir -p Runner/Frameworks
   cp -R CastarSDK.framework Runner/Frameworks/
   ```

2. **Update Info.plist**:
   Add the following to `Runner/Info.plist`:
   ```xml
   <key>CFBundleFrameworks</key>
   <array>
       <string>CastarSDK.framework</string>
   </array>
   ```

## Prerequisites

- `CastarSDK.framework` must be present in the `ios/` directory
- App must be built first (either via Flutter or Xcode)
- Scripts must be run from the `ios/` directory

## Verification

After integration, verify that:

1. `Runner/Frameworks/CastarSDK.framework` exists
2. `Runner/Info.plist` contains the framework reference
3. App launches without "No such module" errors
4. CastarSDK initializes properly in `AppDelegate.swift`

## Troubleshooting

### "No such module 'CastarSDK'" Error
- Ensure `CastarSDK.framework` is in the `ios/` directory
- Verify the framework was copied to `Runner/Frameworks/`
- Check that Info.plist contains the framework reference

### Script Permission Errors
```bash
chmod +x post_build_integrate.sh
chmod +x manual_integrate.sh
```

### Build Failures
- Clean the project: `flutter clean`
- Rebuild: `flutter build ios --release --no-codesign`
- Run integration script again

## Benefits of Post-Build Integration

1. **Reliability**: Avoids build-time linking issues
2. **Simplicity**: No complex Xcode project modifications
3. **Consistency**: Works across different build environments
4. **Maintainability**: Easy to update and modify
5. **CI/CD Friendly**: Automated integration in pipelines

## Files

- `post_build_integrate.sh`: Automated integration for CI/CD
- `manual_integrate.sh`: Manual integration script
- `CastarSDK.framework`: The SDK framework file
- `AppDelegate.swift`: Contains CastarSDK initialization code 