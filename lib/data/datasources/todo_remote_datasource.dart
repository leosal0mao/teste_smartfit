import '../models/response_models/todo_response_model.dart';

abstract class TodoRemoteDataSource {
  Future<TodoResponseModel> getTodos(int limit);
}
