import 'package:auto_route/auto_route.dart';
import 'package:auth_ui/login_page.dart';

part 'login_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class LoginRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
      ];
}
