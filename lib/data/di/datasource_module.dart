import '../../dependency_injection.dart';
import '../datasources/implementations/todo_remote_datasource_impl.dart';

mixin DatasourceModule {
  static Future<void> configureDatasourceModuleInjection() async {
    getIt.registerLazySingleton(
      () => TodoRemoteDataSourceImpl(dioAdapter: getIt.get()),
    );
  }
}
