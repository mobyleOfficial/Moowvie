import 'package:auto_route/auto_route.dart';
import 'package:new_user_record/new_user_record_page.dart';

part 'new_user_record_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class NewUserRecordRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NewUserRecordRoute.page),
      ];
}
