import 'dart:convert';

import 'package:teste_smartfit/core/network/dio_adapter.dart';

import '../../../core/constants/api_constants.dart';
import '../../models/response_models/todo_response_model.dart';
import '../todo_remote_datasource.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final DioAdapter adapter;

  TodoRemoteDataSourceImpl({required this.adapter});

  @override
  Future<TodoResponseModel> getTodos(int limit) async {
    final url = '${ApiConstants.baseUrl}/todos?limit=$limit';
    final response = await adapter.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return TodoResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
