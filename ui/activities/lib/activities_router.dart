import 'package:activities/activities_page.dart';
import 'package:auto_route/auto_route.dart';

part 'activities_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class ActivitiesRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ActivitiesRoute.page),
      ];
}
