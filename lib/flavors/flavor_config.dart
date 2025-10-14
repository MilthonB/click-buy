import 'package:clickbuy/src/config/helper/env.dart';

enum Flavor { dev, staging, prod }

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;
  final String name;

  static FlavorConfig? _instance;


  FlavorConfig._({
    required this.flavor,
    required this.baseUrl,
    required this.name,
  });

  factory FlavorConfig({
    required Flavor flavor,
    required String baseUrl,
    required String name,
  }) {
    _instance ??= FlavorConfig._(flavor: flavor, baseUrl: baseUrl, name: name);
    return _instance!;
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('Not initialized');
    }
    return _instance!;
  }

  static bool isDev() => instance.flavor == Flavor.dev;

  static bool isStaging() => instance.flavor == Flavor.staging;

  static bool isProd() => instance.flavor == Flavor.prod;

  static void setupFlavor(Flavor flavor) {

    switch (flavor) {
      case Flavor.dev:
        FlavorConfig(
          flavor: flavor,
          baseUrl: Env.baseUrlDev, // esta estoy usando actalmente
          name: 'Development',
        );
        break;
      case Flavor.staging:
        FlavorConfig(
          flavor: flavor,
          baseUrl: Env.baseUrlStaging, // ejemplo: aqui ira otra api de staging
          name: 'Staging',
        );
        break;
      case Flavor.prod:
        FlavorConfig(
          flavor: flavor,
          baseUrl: Env.baseUrlProd, // ejemplo: aqui ira otra api de prod
          name: 'Production',
        );
        break;
    }
  }
}
