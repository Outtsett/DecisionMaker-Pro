# 🎯 DecisionMaker Pro

**A Flutter app with physics-based decision-making tools featuring realistic animations and haptic feedback**

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)

## ✨ Features

### 🪙 **Coin Flip**
- Realistic physics-based coin flipping animation
- Shake-to-flip functionality for hands-free operation
- Flip statistics tracking with heads/tails count
- Cross-platform haptic feedback

### 🎲 **Dice Roll**
- Multiple dice support (1-6 dice)
- Variable dice sides (4, 6, 8, 12, 20 sides)
- Realistic rolling physics with random rotation
- Shake detection for natural dice rolling

### 🔮 **Magic 8-Ball**
- Classic Magic 8-Ball experience with 20 responses
- 3D shake animations with realistic physics
- Bubble animation for answer reveals
- Customizable interaction settings

### 🎡 **Decision Wheel**
- Customizable options wheel
- Physics-based spinning with deceleration
- Shake-to-spin functionality
- Dynamic color-coded sections

## 🚀 Physics Engine

### **Advanced Physics System**
- **Realistic Motion**: All animations use physics-based curves for natural movement
- **Cross-Platform Sensors**: Smart accelerometer detection with web-safe fallbacks
- **Haptic Feedback**: Contextual vibration patterns for enhanced user experience
- **Performance Optimized**: Platform-specific optimizations for smooth performance

### **Key Physics Features**
- Gravity compensation for accurate shake detection
- Debounced sensor input to prevent rapid-fire triggers
- Configurable thresholds for different interaction sensitivities
- Transform utilities for 3D effects and realistic animations

## 🛠️ Technical Architecture

### **Core Components**
```
lib/
├── services/
│   └── physics_engine.dart      # Comprehensive physics system
├── widgets/
│   ├── coin_flip.dart          # Coin flipping widget
│   ├── dice_roll.dart          # Dice rolling widget
│   ├── magic_8ball.dart        # Magic 8-ball widget
│   └── decision_wheel.dart     # Decision wheel widget
├── theme/
│   ├── app_theme.dart          # App-wide theming
│   └── visual_themes.dart      # Visual theme system
└── main.dart                   # App entry point
```

### **Physics Engine Classes**
- **`PhysicsEngine`**: Core physics calculations and utilities
- **`ShakeDetector`**: Cross-platform accelerometer management
- **`PhysicsAnimations`**: Pre-defined realistic animation sequences
- **`PhysicsTransforms`**: Widget transformation utilities
- **`HapticManager`**: Contextual haptic feedback system
- **`PhysicsConfig`**: Configurable physics presets for each widget

## 📱 Platform Support

- ✅ **Android** - Full feature support with haptic feedback
- ✅ **iOS** - Full feature support with haptic feedback  
- ✅ **Web** - Optimized experience without sensor dependencies
- ✅ **Desktop** - Cross-platform compatibility

## 🎨 Design Features

### **Visual Effects**
- Smooth 60fps animations across all platforms
- 3D transform effects for immersive experience
- Gradient backgrounds and shadow effects
- Responsive design for all screen sizes

### **User Experience**
- Intuitive gesture-based interactions
- Multiple input methods (tap, shake, button)
- Real-time feedback with animations and haptics
- Statistics tracking for user engagement

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK (>=3.0.0)
- Dart SDK (>=2.17.0)

### **Dependencies**
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.3.6
  sensors_plus: ^6.1.1
  shared_preferences: ^2.3.2
```

### **Installation**
1. Clone the repository:
   ```bash
   git clone https://github.com/Outtsett/DecisionMaker-Pro.git
   cd DecisionMaker-Pro
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### **Building for Production**
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 🔧 Configuration

### **Physics Settings**
The app includes configurable physics presets for each widget:

```dart
// Example: Coin flip configuration
static const PhysicsConfig coinFlip = PhysicsConfig(
  shakeThreshold: 10.0,           // Light shake sensitivity
  debounceMs: 500,                // Quick response time
  animationDuration: 2000,        // Smooth 2-second animation
  transformIntensity: 0.8,        // Moderate visual effects
);
```

### **Customization Options**
- Shake sensitivity levels
- Animation speeds and curves
- Haptic feedback intensity
- Visual theme preferences

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

## 📐 Architecture Principles

### **State Management**
- **Riverpod** for reactive state management
- Provider-based architecture for clean separation
- Immutable state objects for predictable behavior

### **Physics System**
- Modular physics engine for reusability
- Platform-aware implementations
- Configurable parameters for fine-tuning

### **Performance**
- Optimized animations with minimal CPU usage
- Platform-specific optimizations (web vs mobile)
- Memory-efficient widget lifecycle management

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### **Development Guidelines**
- Follow Flutter/Dart style guidelines
- Add tests for new features
- Update documentation for API changes
- Ensure cross-platform compatibility

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Physics concepts inspired by real-world motion
- Community feedback for feature improvements

---

**Made with ❤️ using Flutter**

*Experience the most realistic decision-making tools with advanced physics simulation!*