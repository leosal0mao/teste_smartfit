import 'bloc_module.dart';

mixin PresentationLayerInjection {
  static Future<void> configurePresentationLayerInjection() async {
    await BlocModule.configureStoreModuleInjection();
  }
}
