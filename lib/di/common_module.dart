import 'package:common/common.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CommonModule {
  @lazySingleton
  ShareService shareService() => const SharePlusShareService();
}
