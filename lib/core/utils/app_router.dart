import 'package:e_commerce_app/feature/home/presentation/views/home_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kLoginView = '/login';
  static const kSchoolView = '/school';
  static const kHomeView = '/home';
  static final router = GoRouter(
    routes: [GoRoute(path: '/', builder: (context, state) => const HomeView())],
  );
}
