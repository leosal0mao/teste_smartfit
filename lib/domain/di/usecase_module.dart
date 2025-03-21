import 'package:teste_smartfit/domain/usecases/get_todos.dart';

import '../../dependency_injection.dart';

mixin UsecaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    getIt.registerLazySingleton(
      () => GetTodos(getIt.get()),
    );
  }
}
