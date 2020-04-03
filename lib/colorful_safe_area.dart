library colorful_safe_area;

import 'dart:math';

import 'package:flutter/material.dart';

class ColorfulSafeArea extends StatelessWidget {
  const ColorfulSafeArea({
    Key key,
    this.color = Colors.transparent,
    this.allowOverflow = false,
    this.bottom = true,
    this.left = true,
    this.top = true,
    this.right = true,

    //TODO: implement minimum
    this.minimum = EdgeInsets.zero,

    //TODO: implement maintainBottomViewPadding
    this.maintainBottomViewPadding = false,
    @required this.child,
  })  : assert(left != null),
        assert(top != null),
        assert(right != null),
        assert(bottom != null),
        super(key: key);

  final Color color;
  final bool allowOverflow;

  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;
  final bool maintainBottomViewPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        (allowOverflow)
            ? child
            : SafeArea(
                left: left,
                top: top,
                right: right,
                bottom: bottom,
                minimum: minimum,
                maintainBottomViewPadding: maintainBottomViewPadding,
                child: child,
              ),
        _TopAndBottom(
          color: color,
          top: top,
          bottom: bottom,
          minimum: minimum,
        ),
        _LeftAndRight(
          color: color,
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          minimum: minimum,
        ),
      ],
    );
  }
}

class _TopAndBottom extends StatelessWidget {
  const _TopAndBottom({
    Key key,
    @required this.color,
    @required this.top,
    @required this.bottom,
    @required this.minimum,
  }) : super(key: key);

  final Color color;
  final bool top;
  final bool bottom;
  final EdgeInsets minimum;

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = data.padding;
    print(padding.top);

    return IgnorePointer(
      child: Column(
        children: <Widget>[
          (top)
              ? Container(
                  height: max(padding.top, minimum.top),
                  color: color,
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          Expanded(
            child: Container(
              height: 0.0,
              width: 0.0,
            ),
          ),
          (bottom)
              ? Container(
                  height: max(padding.bottom, minimum.bottom),
                  color: color,
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
        ],
      ),
    );
  }
}

class _LeftAndRight extends StatelessWidget {
  const _LeftAndRight({
    Key key,
    @required this.color,
    @required this.left,
    @required this.top,
    @required this.right,
    @required this.bottom,
    @required this.minimum,
  }) : super(key: key);

  final Color color;
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = data.padding;
    print(padding.top);

    return IgnorePointer(
      child: Row(
        children: <Widget>[
          (left)
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: max(padding.top, minimum.top),
                    ),
                    Container(
                      width: max(padding.left, minimum.left),
                      height: (top)
                          ? MediaQuery.of(context).size.height / 2 -
                              max(padding.top, minimum.top)
                          : MediaQuery.of(context).size.height / 2,
                      color: color,
                    ),
                    Container(
                      width: max(padding.left, minimum.left),
                      height: (bottom)
                          ? MediaQuery.of(context).size.height / 2 -
                              max(padding.bottom, minimum.bottom)
                          : MediaQuery.of(context).size.height / 2,
                      color: color,
                    ),
                  ],
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          Expanded(
            child: Container(
              height: 0.0,
              width: 0.0,
            ),
          ),
          (right)
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: max(padding.top, minimum.top),
                    ),
                    Container(
                      width: max(padding.right, minimum.right),
                      height: (top)
                          ? MediaQuery.of(context).size.height / 2 -
                              max(padding.top, minimum.top)
                          : MediaQuery.of(context).size.height / 2,
                      color: color,
                    ),
                    Container(
                      width: max(padding.right, minimum.right),
                      height: (bottom)
                          ? MediaQuery.of(context).size.height / 2 -
                              max(padding.bottom, minimum.bottom)
                          : MediaQuery.of(context).size.height / 2,
                      color: color,
                    ),
                  ],
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
        ],
      ),
    );
  }
}
