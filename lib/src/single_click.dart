import 'package:flutter/widgets.dart';

/// SingleClick Widget
class SingleClick extends StatefulWidget {
  const SingleClick(
      {Key? key,
      required this.child,
      this.interval = const Duration(milliseconds: 300)})
      : super(key: key);
  final Widget child;
  // 间隔
  final Duration interval;

  @override
  State<SingleClick> createState() => _SingleClickState();
}

class _SingleClickState extends State<SingleClick> {
  // 忽略中
  bool ignoring = false;
  // 执行忽略中
  bool handleIgnore = true;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (ignoring) return;
        if (handleIgnore) {
          ignoring = true;
          setState(() {});
          resetIgnore();
        }
      },
      onPointerUp: (event) {
        handleIgnore = true;
      },
      child: IgnorePointer(
        ignoring: ignoring,
        child: widget.child,
      ),
    );
  }

  // 重置忽略
  Future<void> resetIgnore() async {
    await Future.delayed(widget.interval);
    ignoring = false;
    setState(() {});
  }
}
