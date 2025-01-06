import 'package:flutter/material.dart';
import 'package:flutter_application_manthan/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'widgets/my_app.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox('users'); // Open a box
  runApp(
    MaterialApp(
      theme: theme,
      home: const MyApp(),
    ),
  );
}
