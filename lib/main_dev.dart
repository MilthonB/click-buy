


import 'package:clickbuy/firebase_options.dart';
import 'package:clickbuy/flavors/flavor_config.dart';
import 'package:clickbuy/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  FlavorConfig.setupFlavor(Flavor.dev);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'dev',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
} 