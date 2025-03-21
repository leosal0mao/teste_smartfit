import 'package:teste_smartfit/data/repositories/todo_repository_impl.dart';
import 'package:teste_smartfit/domain/repositories/todo_repository.dart';

import '../../dependency_injection.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    getIt.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(getIt.get()),
    );
  }
}
