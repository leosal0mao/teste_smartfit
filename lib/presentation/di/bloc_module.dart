import 'package:teste_smartfit/presentation/pages/todo/bloc/todo_bloc.dart';

import '../../dependency_injection.dart';

mixin BlocModule {
  static Future<void> configureStoreModuleInjection() async {
    getIt.registerLazySingleton<TodoBloc>(
      () => TodoBloc(remoteDataSource: getIt.get()),
    );
  }
}
