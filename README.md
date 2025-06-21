# CastarSDK Flutter iOS App

A beautiful Flutter iOS app with CastarSDK integration for monetizing your applications. This app provides a modern, user-friendly interface for entering and managing CastarSDK client IDs.

## Features

- 🎨 Modern Material Design 3 UI with gradient backgrounds
- 📱 Responsive design optimized for iOS
- ✅ CastarSDK integration for app monetization
- 🎯 Real-time SDK status and feedback
- 🔒 Input validation for client ID
- 📋 Display of submitted client IDs
- 💰 Revenue generation capabilities

## CastarSDK Integration

This app includes full CastarSDK integration for iOS:

- **Automatic SDK initialization** on app launch
- **Client ID management** through the UI
- **Method channel communication** between Flutter and native iOS code
- **Error handling** and status feedback
- **Revenue tracking** capabilities

### CastarSDK Features

- Supports iOS 12.0+ and Xcode 15.3+
- Automatic revenue generation after 48 hours
- Complete integration solution
- Dashboard for revenue data tracking

## Screenshots

The app features:
- Clean, minimalist design with purple theme
- CastarSDK status indicator
- Smooth animations and transitions
- Intuitive user interface
- Success feedback with visual indicators

## Getting Started

### Prerequisites

- Flutter SDK (>=3.2.3)
- iOS development environment (Xcode 15.3+)
- iOS Simulator or physical iOS device (iOS 12.0+)
- CastarSDK client ID

### Installation

1. Clone the repository:
```bash
git clone https://github.com/srujan5570/ios-play.git
cd ios-play/my_time
```

2. Install dependencies:
```bash
flutter pub get
```

3. Install iOS dependencies:
```bash
cd ios
pod install
cd ..
```

4. Run the app:
```bash
flutter run
```

### Building for iOS

To build the app for iOS:

```bash
flutter build ios
```

## Usage

1. Launch the app
2. The CastarSDK will automatically initialize
3. Enter your CastarSDK client ID in the text field
4. Tap "Initialize CastarSDK" button
5. View the success confirmation with your entered ID
6. Your app is now ready to generate revenue!

## CastarSDK Setup

### Step 1: Apply for Client ID
- Go to CastarSDK applications
- Add a new application
- Create your Client ID for iOS

### Step 2: Integration
The CastarSDK is already integrated in this project:
- CastarSDK.framework is included
- Native iOS code handles SDK initialization
- Flutter UI provides client ID management

### Step 3: Revenue Generation
- After 48 hours, you'll see revenue data in your dashboard
- The SDK automatically handles monetization
- No additional code required

## Project Structure

```
my_time/
├── lib/
│   └── main.dart              # Main Flutter application with CastarSDK UI
├── ios/
│   ├── CastarSDK.framework/   # CastarSDK framework
│   ├── Runner/
│   │   └── AppDelegate.swift  # Native iOS code with CastarSDK integration
│   └── Podfile               # CocoaPods configuration
├── .github/workflows/
│   └── ios-ipa-build.yml     # GitHub Actions for iOS builds
├── pubspec.yaml              # Dependencies and app configuration
└── README.md                 # This file
```

## Dependencies

- Flutter SDK
- cupertino_icons: ^1.0.2
- flutter_lints: ^2.0.0
- CastarSDK.framework (included)

## Development

This app is built using Flutter and follows Material Design 3 guidelines. The main features include:

- **State Management**: Uses Flutter's built-in StatefulWidget for local state
- **Native Integration**: Method channels for Flutter-iOS communication
- **CastarSDK Integration**: Full SDK integration for monetization
- **Form Validation**: Implements form validation with custom error messages
- **UI/UX**: Modern design with gradients, shadows, and smooth animations
- **Responsive Design**: Adapts to different screen sizes

## GitHub Actions

The project includes automated iOS builds:
- Automatic IPA generation on every push
- Release creation and asset upload
- macOS runner with Flutter and iOS tools

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).

## Support

For support or questions:
- CastarSDK documentation: [CastarSDK Documentation](https://download.castarsdk.com/ios.zip)
- GitHub issues: Open an issue on the repository

---

Built with ❤️ using Flutter and CastarSDK
