import 'package:teste_smartfit/data/di/datasource_module.dart';
import 'package:teste_smartfit/data/di/network_module.dart';
import 'package:teste_smartfit/data/di/repository_module.dart';

mixin DataLayerInjection {
  static Future<void> configureDataLayerInjection() async {
    await RepositoryModule.configureRepositoryModuleInjection();
    await DatasourceModule.configureDatasourceModuleInjection();
    await NetworkModule.configureNetworkModuleInjection();
  }
}
