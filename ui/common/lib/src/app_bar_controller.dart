import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// AppBarController — per-tab title overrides
// ---------------------------------------------------------------------------

class AppBarController extends ChangeNotifier {
  final Map<int, String> _overrides = {};
  VoidCallback? backAction;

  String? titleForTab(int tabIndex) => _overrides[tabIndex];

  void setTitle({
    required int tabIndex,
    required String? title,
    VoidCallback? onBack,
  }) {
    final current = _overrides[tabIndex];
    if (current == title) return;
    if (title == null) {
      _overrides.remove(tabIndex);
      backAction = null;
    } else {
      _overrides[tabIndex] = title;
      backAction = onBack;
    }
    notifyListeners();
  }
}

class AppBarControllerScope extends InheritedNotifier<AppBarController> {
  const AppBarControllerScope({
    super.key,
    required AppBarController super.notifier,
    required super.child,
  });

  static AppBarController? find(BuildContext context) =>
      context.findAncestorWidgetOfExactType<AppBarControllerScope>()?.notifier;
}

// ---------------------------------------------------------------------------
// TabIndexScope — lightweight wrapper so pages can read their tab index
// once at mount without creating any InheritedWidget dependency
// ---------------------------------------------------------------------------

class TabIndexScope extends StatelessWidget {
  final int tabIndex;
  final Widget child;

  const TabIndexScope({
    super.key,
    required this.tabIndex,
    required this.child,
  });

  static int? find(BuildContext context) =>
      context.findAncestorWidgetOfExactType<TabIndexScope>()?.tabIndex;

  @override
  Widget build(BuildContext context) => child;
}
