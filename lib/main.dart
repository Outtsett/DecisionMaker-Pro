import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'services/shader_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Initialize shared preferences
  await SharedPreferences.getInstance();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.darkBackground,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    const ProviderScope(
      child: DecisionMakerProApp(),
    ),
  );
}

class DecisionMakerProApp extends ConsumerWidget {
  const DecisionMakerProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize shaders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shaderManagerProvider).initialize();
    });
    
    return MaterialApp(
      title: 'DecisionMaker Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0), // Prevent font scaling
          ),
          child: child!,
        );
      },
    );
  }
}