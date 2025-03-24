import 'package:teste_smartfit/presentation/pages/todo/view/todo_page.dart';

import '../../presentation/pages/todo/view/home_page.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = {
    '/': (context) => const HomePage(),
    '/todo': (context) => const TodoPage(),
  };
}
