import 'package:flutter/material.dart';

import 'dependency_injection.dart';
import 'presentation/app.dart';

void main() async {
  await DependencyInjection.configureDependencies();
  runApp(const App());
}
