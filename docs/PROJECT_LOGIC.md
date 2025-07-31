# 📋 Project Logic & Implementation Guide

## 🏗️ Architecture Overview

DecisionMaker Pro is built using a modular, physics-based architecture that prioritizes:

- **Realistic interactions** through physics simulation
- **Cross-platform compatibility** with optimized experiences
- **Maintainable code** through separation of concerns
- **Performance optimization** for smooth 60fps animations

## 🧩 Core Components

### **1. Physics Engine (`lib/services/physics_engine.dart`)**

The heart of the application, providing:

#### **PhysicsEngine Class**
- Acceleration magnitude calculations
- Gravity compensation for accurate motion detection
- Shake detection algorithms
- Debounce mechanisms for performance

#### **ShakeDetector Class**
- Cross-platform accelerometer management
- Web-safe implementations
- Event-driven shake detection
- Configurable sensitivity thresholds

#### **PhysicsAnimations Class**
- Pre-built animation sequences for:
  - Coin flip rotations (8π rotations)
  - Dice roll physics (3-5 random rotations)
  - Wheel deceleration curves
  - Magic 8-ball shake effects
  - 3D transform animations

#### **PhysicsTransforms Class**
- Reusable transformation widgets
- 3D rotation matrices
- Scale animations
- Shake translation effects

#### **HapticManager Class**
- Platform-aware haptic feedback
- Contextual vibration patterns
- Sequence-based feedback for dramatic effects

### **2. Widget Architecture**

Each decision tool follows a consistent pattern:

```dart
class DecisionWidget extends ConsumerStatefulWidget {
  // Riverpod state management
  // Physics-based animations
  // Cross-platform sensor integration
  // Haptic feedback coordination
}
```

#### **Coin Flip (`lib/widgets/coin_flip.dart`)**
- **Physics**: 8π rotation with easeInOut curve
- **Interaction**: Tap, button, or shake to flip
- **Animation**: 2-second realistic physics simulation
- **Feedback**: Light haptic on start, heavy on completion
- **Statistics**: Heads/tails tracking with reset capability

#### **Dice Roll (`lib/widgets/dice_roll.dart`)**
- **Physics**: Variable rotations (3-5x) with easeOut curve
- **Customization**: 1-6 dice, 4-20 sides per die
- **Animation**: 1.5-second rolling with random factors
- **Interaction**: Shake-sensitive for natural feel
- **Results**: Sum calculation and individual die display

#### **Magic 8-Ball (`lib/widgets/magic_8ball.dart`)**
- **Physics**: Multi-phase shake animation with elastic curves
- **Responses**: Classic 20 Magic 8-Ball answers
- **Animation**: Bubble rising effect for answer reveal
- **3D Effects**: Perspective transforms for depth
- **Settings**: Customizable interaction preferences

#### **Decision Wheel (`lib/widgets/decision_wheel.dart`)**
- **Physics**: Deceleration-based spinning (10x rotations)
- **Customization**: Add/remove/edit wheel options
- **Animation**: 3-second realistic wheel physics
- **Selection**: Precise angle calculation for results
- **Visual**: Color-coded sections with smooth gradients

### **3. State Management Strategy**

Using **Flutter Riverpod** for predictable state:

```dart
// Widget-specific providers
final isFlippingProvider = StateProvider<bool>((ref) => false);
final coinResultProvider = StateProvider<String?>((ref) => null);

// Global physics configuration
final physicsConfigProvider = StateProvider<PhysicsConfig>((ref) => 
  PhysicsConfig.defaultConfig);
```

#### **Benefits:**
- Immutable state objects
- Automatic widget rebuilding
- Easy testing and debugging
- Clear data flow

### **4. Performance Optimization**

#### **Platform-Specific Optimizations:**
- **Web**: Disabled sensors, reduced shadow effects
- **Mobile**: Full haptic feedback, accelerometer integration
- **Desktop**: Optimized for mouse/keyboard interaction

#### **Animation Performance:**
- Pre-calculated physics curves
- Optimized transform matrices
- Conditional effect rendering
- Memory-efficient controller management

#### **Cross-Platform Sensor Handling:**
```dart
void start() {
  if (kIsWeb) {
    debugPrint('Accelerometer not supported on web platform');
    return;
  }
  // Initialize sensors only on supported platforms
}
```

## 🎨 Visual Design System

### **Theme Architecture (`lib/theme/`)**
- **Dark-first design** with gradient accents
- **Consistent color palette** across all widgets
- **Responsive typography** with controlled scaling
- **Material Design 3** principles

### **Animation Principles**
- **Realistic physics** - All animations follow natural motion curves
- **Consistent timing** - Standardized durations for user expectations
- **Contextual feedback** - Visual and haptic responses for every action
- **Performance-first** - 60fps target across all platforms

## 🔧 Configuration System

### **Physics Presets**
Each widget has optimized physics parameters:

```dart
static const PhysicsConfig coinFlip = PhysicsConfig(
  shakeThreshold: 10.0,      // Light sensitivity
  debounceMs: 500,           // Quick response
  animationDuration: 2000,   // Smooth experience
  transformIntensity: 0.8,   // Moderate effects
);
```

### **Customization Points**
- Shake sensitivity levels
- Animation speeds
- Haptic feedback intensity
- Visual effect complexity
- Audio preferences

## 🧪 Testing Strategy

### **Unit Tests**
- Physics calculations
- State management logic
- Animation curve validation
- Cross-platform compatibility

### **Widget Tests**
- User interaction flows
- Animation trigger validation
- State changes verification
- Error handling scenarios

### **Integration Tests**
- End-to-end user scenarios
- Performance benchmarking
- Cross-platform feature parity
- Accessibility compliance

## 🚀 Build & Deployment

### **Development Commands**
```bash
# Install dependencies
flutter pub get

# Run with hot reload
flutter run

# Build for specific platforms
flutter build apk --release      # Android
flutter build ios --release      # iOS
flutter build web --release      # Web
```

### **Performance Monitoring**
- Frame rate monitoring
- Memory usage tracking
- Animation performance metrics
- Cross-platform consistency validation

## 📈 Future Enhancement Areas

### **Potential Features**
1. **Additional Decision Tools**
   - Spinner games
   - Card draws
   - Yes/no pendulum

2. **Enhanced Physics**
   - Realistic collision detection
   - Advanced particle effects
   - Weather-based randomization

3. **Social Features**
   - Decision sharing
   - Group decision rooms
   - Statistics comparison

4. **Accessibility**
   - Voice commands
   - Screen reader optimization
   - Motor accessibility options

## 🔍 Code Quality Standards

### **Architecture Principles**
- **Single Responsibility**: Each class has one clear purpose
- **Open/Closed**: Easy to extend, difficult to break
- **Dependency Inversion**: Depend on abstractions, not concretions
- **DRY Principle**: Shared physics utilities prevent code duplication

### **Performance Guidelines**
- **60fps target** for all animations
- **< 100ms response time** for user interactions
- **Minimal memory allocation** during animations
- **Efficient widget rebuilding** through selective providers

This documentation provides the foundation for understanding and extending the DecisionMaker Pro codebase.