import 'package:hive_flutter/adapters.dart';

class HiveManager {
  // static late Box<bool> _boxOnboarding;

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('setting');
    // await Hive.openBox<bool>('onboarding');
    // _boxOnboarding = await Hive.openBox<bool>('onboarding');
  }

  // static Box<bool> get boxOnboarding => _boxOnboarding;
}
