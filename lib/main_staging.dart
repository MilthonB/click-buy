


import 'package:clickbuy/firebase_options.dart';
import 'package:clickbuy/flavors/flavor_config.dart';
import 'package:clickbuy/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {

  FlavorConfig.setupFlavor(Flavor.staging);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'staging',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(ProviderScope(child: const MyApp()));
  runApp(const MyApp());
} 