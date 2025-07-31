# 🚀 Getting Started with DecisionMaker Pro

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

### **Required Software**
- **Flutter SDK** (>=3.24.0) - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (>=3.8.1) - Included with Flutter
- **Git** - For version control
- **IDE** - VS Code with Flutter extension or Android Studio

### **Platform-Specific Requirements**

#### **For Android Development:**
- Android Studio or Android SDK Tools
- Android SDK (API level 21 or higher)
- Java Development Kit (JDK 17+)

#### **For iOS Development (macOS only):**
- Xcode (latest stable version)
- iOS Simulator or physical iOS device
- CocoaPods (`sudo gem install cocoapods`)

#### **For Web Development:**
- Modern web browser (Chrome, Firefox, Safari, Edge)
- No additional setup required

## 🛠️ Installation

### **1. Clone the Repository**
```bash
git clone https://github.com/Outtsett/DecisionMaker-Pro.git
cd DecisionMaker-Pro
```

### **2. Install Dependencies**
```bash
flutter pub get
```

### **3. Verify Flutter Installation**
```bash
flutter doctor
```
Ensure all checkmarks are green for your target platforms.

### **4. Run the Application**

#### **Development Mode (Hot Reload):**
```bash
# For mobile (automatically detects connected devices)
flutter run

# For web
flutter run -d chrome

# For specific device
flutter devices  # List available devices
flutter run -d <device-id>
```

#### **Debug Mode:**
```bash
flutter run --debug
```

#### **Release Mode:**
```bash
flutter run --release
```

## 🎯 Platform-Specific Setup

### **Android Setup**

1. **Enable Developer Options** on your Android device
2. **Enable USB Debugging**
3. **Connect device** via USB or use Android Emulator
4. **Accept USB debugging** permission on device

```bash
# Check connected Android devices
adb devices

# Run on Android
flutter run
```

### **iOS Setup (macOS only)**

1. **Open Xcode** and agree to license terms
2. **Set up iOS Simulator** or connect physical device
3. **For physical device**: Enable Developer Mode in Settings

```bash
# List iOS simulators
xcrun simctl list devices

# Run on iOS
flutter run
```

### **Web Setup**

No additional setup required! Simply run:
```bash
flutter run -d chrome
```

## 🔧 Configuration

### **Physics Engine Configuration**

The app comes with pre-configured physics settings, but you can customize them:

```dart
// Example: Modify shake sensitivity
static const PhysicsConfig customConfig = PhysicsConfig(
  shakeThreshold: 12.0,        // Adjust sensitivity (10.0 = light, 20.0 = heavy)
  debounceMs: 750,             // Time between shake detections
  animationDuration: 1800,     // Animation length in milliseconds
  enableHaptics: true,         // Enable/disable haptic feedback
);
```

### **Asset Configuration**

If you add custom assets:

1. **Place files** in appropriate `assets/` directories
2. **Update `pubspec.yaml`** to include new assets
3. **Run `flutter pub get`** to register changes

## 🧪 Development Workflow

### **Hot Reload Development**
1. **Make code changes** in your IDE
2. **Save files** (Ctrl/Cmd + S)
3. **See changes instantly** without restart

### **Debugging**
```bash
# Enable verbose logging
flutter run --verbose

# Run with specific log level
flutter run --debug --verbose
```

### **Performance Profiling**
```bash
# Run with performance monitoring
flutter run --profile

# Analyze with DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

## 📱 Testing

### **Run Unit Tests**
```bash
flutter test
```

### **Run Integration Tests**
```bash
flutter test integration_test/
```

### **Test on Multiple Platforms**
```bash
# Test Android
flutter test --platform android

# Test iOS
flutter test --platform ios

# Test Web
flutter test --platform chrome
```

## 🏗️ Building for Production

### **Android APK**
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### **Android App Bundle (Recommended)**
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### **iOS App**
```bash
flutter build ios --release
```
Then open `ios/Runner.xcworkspace` in Xcode for App Store submission.

### **Web Application**
```bash
flutter build web --release
```
Output: `build/web/` (ready for hosting)

## 🔍 Troubleshooting

### **Common Issues**

#### **"Flutter command not found"**
- Ensure Flutter is in your PATH
- Run `flutter doctor` to verify installation

#### **"No devices found"**
- For Android: Check USB debugging is enabled
- For iOS: Ensure device is trusted and Developer Mode enabled
- For Web: Ensure you specify `-d chrome`

#### **"Package not found" errors**
```bash
flutter clean
flutter pub get
```

#### **Physics/Sensor Issues on Web**
This is expected behavior. The app automatically disables sensor features on web platforms for optimal performance.

#### **Gradle build failures (Android)**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### **Performance Issues**

#### **Slow animations**
- Check if running in debug mode (use `--release` for production performance)
- Verify device performance capabilities
- Consider reducing animation complexity in settings

#### **High memory usage**
- Ensure proper disposal of animation controllers
- Check for memory leaks in development tools

## 📚 Learning Resources

### **Flutter Documentation**
- [Flutter Docs](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)

### **Physics and Animations**
- [Flutter Animations](https://docs.flutter.dev/development/ui/animations)
- [Custom Curves](https://api.flutter.dev/flutter/animation/Curves-class.html)
- [Transform Widgets](https://docs.flutter.dev/development/ui/layout/transformations)

### **State Management (Riverpod)**
- [Riverpod Documentation](https://riverpod.dev/)
- [State Management in Flutter](https://docs.flutter.dev/development/data-and-backend/state-mgmt)

## 🤝 Contributing

Ready to contribute? Check out our [Contributing Guidelines](CONTRIBUTING.md) for:
- Code style standards
- Development workflow
- Pull request process
- Issue reporting

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/Outtsett/DecisionMaker-Pro/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Outtsett/DecisionMaker-Pro/discussions)
- **Documentation**: [Project Logic Guide](docs/PROJECT_LOGIC.md)

---

**Happy Coding! 🎉**

*Get ready to experience the most realistic decision-making tools with physics-based animations!*