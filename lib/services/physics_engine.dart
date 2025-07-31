import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math' as math;
import 'dart:async';

/// A comprehensive physics utility for handling motion, animations, and sensor data
/// across all decision-making widgets in the app.
class PhysicsEngine {
  static const double _defaultShakeThreshold = 15.0;
  static const double _gravity = 9.8; // Standard gravity in m/s²
  static const int _shakeDebounceMs = 1000;

  /// Calculates the acceleration magnitude from accelerometer data
  static double calculateAccelerationMagnitude(AccelerometerEvent event) {
    return math.sqrt(
      event.x * event.x + event.y * event.y + event.z * event.z,
    );
  }

  /// Removes gravity from acceleration to get device movement acceleration
  static double removeGravity(double accelerationMagnitude) {
    return (accelerationMagnitude - _gravity).abs();
  }

  /// Detects if a shake gesture occurred based on acceleration data
  static bool isShakeDetected(
    AccelerometerEvent event, {
    double threshold = _defaultShakeThreshold,
  }) {
    final magnitude = calculateAccelerationMagnitude(event);
    final withoutGravity = removeGravity(magnitude);
    return withoutGravity > threshold;
  }

  /// Checks if enough time has passed since the last shake (debouncing)
  static bool shouldProcessShake(
    DateTime lastShakeTime, {
    int debounceMs = _shakeDebounceMs,
  }) {
    final now = DateTime.now();
    return now.difference(lastShakeTime).inMilliseconds > debounceMs;
  }
}

/// Manages accelerometer subscription and shake detection
class ShakeDetector {
  StreamSubscription<AccelerometerEvent>? _subscription;
  DateTime _lastShakeTime = DateTime.now();
  final double shakeThreshold;
  final int debounceMs;
  final VoidCallback onShake;

  ShakeDetector({
    required this.onShake,
    this.shakeThreshold = 15.0,
    this.debounceMs = 1000,
  });

  /// Starts listening to accelerometer events
  void start() {
    // Skip accelerometer initialization on web platform
    if (kIsWeb) {
      debugPrint('Accelerometer not supported on web platform');
      return;
    }
    
    try {
      // Use the new accelerometerEventStream() instead of deprecated accelerometerEvents
      _subscription = accelerometerEventStream().listen(
        _handleAccelerometerData,
        onError: (error) {
          debugPrint('Accelerometer error: $error');
        },
      );
    } catch (e) {
      debugPrint('Failed to initialize accelerometer: $e');
    }
  }

  /// Stops listening to accelerometer events
  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  void _handleAccelerometerData(AccelerometerEvent event) {
    if (PhysicsEngine.isShakeDetected(event, threshold: shakeThreshold)) {
      if (PhysicsEngine.shouldProcessShake(_lastShakeTime, debounceMs: debounceMs)) {
        _lastShakeTime = DateTime.now();
        onShake();
      }
    }
  }
}

/// Pre-defined animation sequences for common physics effects
class PhysicsAnimations {
  /// Creates a realistic shake animation with multiple phases
  static Animation<double> createShakeAnimation(AnimationController controller) {
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 15.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 15.0, end: -10.0)
            .chain(CurveTween(curve: Curves.elasticInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -10.0, end: 5.0)
            .chain(CurveTween(curve: Curves.elasticInOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 5.0, end: 0.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 25,
      ),
    ]).animate(controller);
  }

  /// Creates a scale animation for impact effects
  static Animation<double> createImpactScaleAnimation(AnimationController controller) {
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 0.95)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(controller);
  }

  /// Creates a bubble rising animation for answer reveals
  static Animation<double> createBubbleAnimation(AnimationController controller) {
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.0),
        weight: 40, // Delay
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 60, // Rising bubble effect
      ),
    ]).animate(controller);
  }

  /// Creates a 3D rotation animation
  static Animation<double> create3DRotationAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.0,
      end: math.pi * 2,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }

  /// Creates a coin flip rotation animation
  static Animation<double> createCoinFlipAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0,
      end: math.pi * 8, // Multiple rotations for realistic flip
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }

  /// Creates a dice roll animation with random rotations
  static Animation<double> createDiceRollAnimation(
    AnimationController controller, {
    double randomFactor = 1.0,
  }) {
    final random = math.Random();
    final rotations = 3 + (random.nextDouble() * 2 * randomFactor); // 3-5 rotations
    return Tween<double>(
      begin: 0,
      end: math.pi * 2 * rotations,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));
  }

  /// Creates a wheel spin animation with deceleration
  static Animation<double> createWheelSpinAnimation(
    AnimationController controller, {
    double initialVelocity = 10.0,
  }) {
    return Tween<double>(
      begin: 0,
      end: math.pi * 2 * initialVelocity,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    ));
  }
}

/// Utility for applying physics-based transformations
class PhysicsTransforms {
  /// Applies shake transformation to a widget
  static Widget applyShakeTransform({
    required Widget child,
    required Animation<double> shakeAnimation,
    double intensity = 10.0,
  }) {
    return AnimatedBuilder(
      animation: shakeAnimation,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(
            math.sin(shakeAnimation.value * math.pi / 180) * intensity,
            math.cos(shakeAnimation.value * math.pi / 180) * (intensity * 0.5),
          ),
          child: child,
        );
      },
    );
  }

  /// Applies 3D rotation transformation
  static Widget apply3DTransform({
    required Widget child,
    required Animation<double> rotationAnimation,
    double perspective = 0.001,
    double xRotationFactor = 0.1,
    double yRotationFactor = 0.05,
  }) {
    return AnimatedBuilder(
      animation: rotationAnimation,
      builder: (context, _) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, perspective)
            ..rotateX(rotationAnimation.value * xRotationFactor)
            ..rotateY(rotationAnimation.value * yRotationFactor),
          child: child,
        );
      },
    );
  }

  /// Applies scale transformation
  static Widget applyScaleTransform({
    required Widget child,
    required Animation<double> scaleAnimation,
  }) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, _) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: child,
        );
      },
    );
  }

  /// Applies rotation transformation (2D)
  static Widget applyRotationTransform({
    required Widget child,
    required Animation<double> rotationAnimation,
  }) {
    return AnimatedBuilder(
      animation: rotationAnimation,
      builder: (context, _) {
        return Transform.rotate(
          angle: rotationAnimation.value,
          child: child,
        );
      },
    );
  }
}

/// Manages haptic feedback patterns for different actions
class HapticManager {
  /// Plays haptic feedback for shake action
  static Future<void> playShakeFeedback() async {
    await HapticFeedback.mediumImpact();
  }

  /// Plays haptic feedback for button press
  static Future<void> playButtonFeedback() async {
    await HapticFeedback.lightImpact();
  }

  /// Plays haptic feedback for completion
  static Future<void> playCompletionFeedback() async {
    await HapticFeedback.lightImpact();
  }

  /// Plays a sequence of haptic feedback for dramatic effect
  static Future<void> playSequenceFeedback({
    List<int> delays = const [100, 200, 300],
    Future<void> Function() feedbackType = HapticFeedback.lightImpact,
  }) async {
    for (int delay in delays) {
      await Future.delayed(Duration(milliseconds: delay));
      await feedbackType();
    }
  }

  /// Plays heavy impact feedback for significant actions
  static Future<void> playHeavyImpact() async {
    await HapticFeedback.heavyImpact();
  }
}

/// Common physics constants and configurations
class PhysicsConstants {
  // Shake detection
  static const double lightShakeThreshold = 10.0;
  static const double mediumShakeThreshold = 15.0;
  static const double heavyShakeThreshold = 20.0;
  
  // Animation durations (in milliseconds)
  static const int quickAnimationDuration = 600;
  static const int mediumAnimationDuration = 1200;
  static const int slowAnimationDuration = 2000;
  
  // Debounce times
  static const int quickDebounce = 500;
  static const int mediumDebounce = 1000;
  static const int slowDebounce = 1500;
  
  // Physics values
  static const double earthGravity = 9.8;
  static const double moonGravity = 1.6;
  static const double marsGravity = 3.7;
  
  // Common rotation values
  static const double quarterTurn = math.pi / 2;
  static const double halfTurn = math.pi;
  static const double fullTurn = math.pi * 2;
}

/// A complete physics configuration for a widget
class PhysicsConfig {
  final double shakeThreshold;
  final int debounceMs;
  final int animationDuration;
  final Curve animationCurve;
  final double transformIntensity;
  final bool enableHaptics;

  const PhysicsConfig({
    this.shakeThreshold = PhysicsConstants.mediumShakeThreshold,
    this.debounceMs = PhysicsConstants.mediumDebounce,
    this.animationDuration = PhysicsConstants.mediumAnimationDuration,
    this.animationCurve = Curves.easeInOut,
    this.transformIntensity = 1.0,
    this.enableHaptics = true,
  });

  /// Preset for coin flip
  static const PhysicsConfig coinFlip = PhysicsConfig(
    shakeThreshold: PhysicsConstants.lightShakeThreshold,
    debounceMs: PhysicsConstants.quickDebounce,
    animationDuration: PhysicsConstants.slowAnimationDuration,
    animationCurve: Curves.easeInOut,
    transformIntensity: 0.8,
  );

  /// Preset for dice roll
  static const PhysicsConfig diceRoll = PhysicsConfig(
    shakeThreshold: PhysicsConstants.mediumShakeThreshold,
    debounceMs: PhysicsConstants.mediumDebounce,
    animationDuration: 1500,
    animationCurve: Curves.easeOut,
    transformIntensity: 1.2,
  );

  /// Preset for magic 8-ball
  static const PhysicsConfig magic8Ball = PhysicsConfig(
    shakeThreshold: PhysicsConstants.mediumShakeThreshold,
    debounceMs: PhysicsConstants.mediumDebounce,
    animationDuration: PhysicsConstants.mediumAnimationDuration,
    animationCurve: Curves.elasticOut,
    transformIntensity: 1.0,
  );

  /// Preset for decision wheel
  static const PhysicsConfig decisionWheel = PhysicsConfig(
    shakeThreshold: PhysicsConstants.heavyShakeThreshold,
    debounceMs: PhysicsConstants.slowDebounce,
    animationDuration: 3000,
    animationCurve: Curves.decelerate,
    transformIntensity: 0.5,
  );
}