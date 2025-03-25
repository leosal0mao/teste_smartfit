import 'package:mockito/annotations.dart';

import 'package:teste_smartfit/core/network/dio_adapter.dart';
import 'package:teste_smartfit/data/datasources/todo_remote_datasource.dart';

@GenerateNiceMocks([MockSpec<TodoRemoteDataSource>()])
@GenerateNiceMocks([MockSpec<DioAdapter>()])
void main() {}
