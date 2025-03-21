import 'package:teste_smartfit/data/datasources/implementations/todo_remote_datasource_impl.dart';

import '../../dependency_injection.dart';

mixin DatasourceModule {
  static Future<void> configureDatasourceModuleInjection() async {
    getIt.registerLazySingleton(
      () => TodoRemoteDataSourceImpl(adapter: getIt.get()),
    );
  }
}
