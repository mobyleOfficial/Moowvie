import 'package:flutter/material.dart';

class MoovieKeepAliveTab extends StatefulWidget {
  final Widget child;

  const MoovieKeepAliveTab({super.key, required this.child});

  @override
  State<MoovieKeepAliveTab> createState() => _MoovieKeepAliveTabState();
}

class _MoovieKeepAliveTabState extends State<MoovieKeepAliveTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
