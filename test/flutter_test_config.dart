import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Keep test output readable: EasyLocalization logs every build by default.
  EasyLocalization.logger.enableBuildModes = [];

  await testMain();
}
