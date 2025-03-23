import 'package:get_it/get_it.dart';
import 'package:teste_smartfit/domain/di/domain_injection.dart';
import 'package:teste_smartfit/presentation/di/presentation_injection.dart';

import 'data/di/data_injection.dart';

GetIt getIt = GetIt.instance;

mixin DependencyInjection {
  static Future<void> configureDependencies() async {
    await DataLayerInjection.configureDataLayerInjection();
    await DomainLayerInjection.configureDomainLayerInjection();
    await PresentationLayerInjection.configurePresentationLayerInjection();
  }
}
