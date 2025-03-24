import '../../dependency_injection.dart';
import '../datasources/implementations/todo_remote_datasource_impl.dart';
import '../datasources/todo_remote_datasource.dart';

mixin DatasourceModule {
  static Future<void> configureDatasourceModuleInjection() async {
    getIt.registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImpl(dioAdapter: getIt.get()),
    );
  }
}
