import 'package:dio/dio.dart';
import 'package:teste_smartfit/core/network/dio_adapter.dart';

import '../../dependency_injection.dart';

mixin NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    getIt.registerFactory<DioAdapter>(() => DioAdapter(Dio()));
  }
}
