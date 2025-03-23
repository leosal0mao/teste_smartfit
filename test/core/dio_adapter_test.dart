import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:teste_smartfit/core/network/dio_adapter.dart';

// Mock do Dio
class MockDio extends Mock implements Dio {}

void main() {
  late DioAdapter dioAdapter;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dioAdapter = DioAdapter(mockDio);
  });

  test('should make a PUT request and return the response data', () async {
    // Arrange
    const url = '/todos/1';
    final data = {
      'id': 1,
      'todo': 'Updated Todo',
      'completed': true,
      'userId': 1,
    };

    final response = Response(
      data: data,
      statusCode: 200,
      requestOptions: RequestOptions(path: url),
    );

    when(mockDio.put(url, data: data)).thenAnswer((_) async => response);

    // Act
    final result = await dioAdapter.put(url, data: data);

    // Assert
    expect(result, data);
    verify(mockDio.put(url, data: data));
    verifyNoMoreInteractions(mockDio);
  });
}
