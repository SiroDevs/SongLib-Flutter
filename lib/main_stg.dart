import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';
import 'core/di/injectable.dart';
import 'core/utils/app_util.dart';
import 'core/utils/env/environments.dart';
import 'core/utils/env/flavor_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: Flavor.staging,
    name: 'STG',
    color: Colors.transparent,
    values: const FlavorValues(
      logNetworkInfo: false,
      showFullErrorMessages: false,
    ),
  );
  logger('Starting app from main_stg.dart');
  await configureDependencies(Environments.staging);

  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    alwaysOnTop: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
  });

  runApp(const MyApp());
}
