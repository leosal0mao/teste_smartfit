import 'usecase_module.dart';

mixin DomainLayerInjection {
  static Future<void> configureDomainLayerInjection() async {
    await UsecaseModule.configureUseCaseModuleInjection();
  }
}
