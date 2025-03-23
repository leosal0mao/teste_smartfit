import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_smartfit/presentation/pages/todo/bloc/todo_bloc.dart';

import '../dependency_injection.dart';

final blocProviders = [
  BlocProvider<TodoBloc>(
    create: (context) => getIt<TodoBloc>(),
  ),
];
