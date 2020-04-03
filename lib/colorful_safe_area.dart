library colorful_safe_area;

import 'package:flutter/material.dart';

class ColorfulSafeArea extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool allowOverflow;
  final bool bottom;

  const ColorfulSafeArea({
    Key key,
    @required this.child,
    this.color = Colors.transparent,
    this.allowOverflow = false,
    this.bottom = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        (allowOverflow) ? child : SafeArea(child: child),
        _TopAndBottom(color: color),
        _LeftAndRight(color: color),
      ],
    );
  }
}

class _TopAndBottom extends StatelessWidget {
  final Color color;

  const _TopAndBottom({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = data.padding;
    print(padding.top);

    return IgnorePointer(
      child: Column(
        children: <Widget>[
          Container(
            height: padding.top,
            color: color,
          ),
          Expanded(
            child: Container(
              height: 0.0,
              width: 0.0,
              color: Colors.transparent,
            ),
          ),
          Container(
            height: padding.bottom,
            color: color,
          ),
        ],
      ),
    );
  }
}

class _LeftAndRight extends StatelessWidget {
  final Color color;

  const _LeftAndRight({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = data.padding;
    print(padding.top);

    return IgnorePointer(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: padding.left,
                height: MediaQuery.of(context).size.height / 2 - padding.top,
                color: color,
              ),
              Container(
                width: padding.left,
                height: MediaQuery.of(context).size.height / 2 - padding.bottom,
                color: color,
              ),
            ],
          ),
          Expanded(
            child: Container(
              height: 0.0,
              width: 0.0,
              color: Colors.transparent,
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                width: padding.right,
                height: MediaQuery.of(context).size.height / 2 - padding.top,
                color: color,
              ),
              Container(
                width: padding.right,
                height: MediaQuery.of(context).size.height / 2 - padding.bottom,
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
