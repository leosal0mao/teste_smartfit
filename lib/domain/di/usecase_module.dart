import 'package:teste_smartfit/domain/usecases/create_todo.dart';
import 'package:teste_smartfit/domain/usecases/delete_todo.dart';
import 'package:teste_smartfit/domain/usecases/get_todos.dart';
import 'package:teste_smartfit/domain/usecases/update_todo.dart';

import '../../dependency_injection.dart';

mixin UsecaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    getIt.registerLazySingleton(
      () => GetTodosUsecase(getIt.get()),
    );

    getIt.registerLazySingleton(
      () => CreateTodoUsecase(getIt.get()),
    );

    getIt.registerLazySingleton(
      () => UpdateTodoUsecase(getIt.get()),
    );

    getIt.registerLazySingleton(
      () => DeleteTodoUsecase(getIt.get()),
    );
  }
}
