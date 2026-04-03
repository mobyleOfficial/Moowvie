import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// TabIndexScope — lightweight wrapper so widgets can detect whether they
// are inside the main tabbed screen (e.g. to decide whether to render
// their own AppBar or let the main app bar handle it).
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
