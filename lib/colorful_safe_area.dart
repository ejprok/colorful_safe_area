library colorful_safe_area;

import 'dart:math';

import 'package:flutter/material.dart';

class ColorfulSafeArea extends StatelessWidget {
  const ColorfulSafeArea({
    Key key,
    this.color = Colors.transparent,
    this.allowOverflow = false,
    this.overflowTappable = false,
    this.bottom = true,
    this.left = true,
    this.top = true,
    this.right = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
    @required this.child,
  })  : assert(color != null),
        assert(allowOverflow != null),
        assert(overflowTappable != null),
        assert(left != null),
        assert(top != null),
        assert(right != null),
        assert(bottom != null),
        super(key: key);

  final Color color;
  final bool allowOverflow;
  final bool overflowTappable;

  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;
  final bool maintainBottomViewPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = EdgeInsets.only(
      left: (left) ? max(data.padding.left, minimum.left) : minimum.left,
      top: (top) ? max(data.padding.top, minimum.top) : minimum.top,
      right: (right) ? max(data.padding.right, minimum.right) : minimum.right,
      bottom:
          (bottom) ? max(data.padding.bottom, minimum.bottom) : minimum.bottom,
    );
    if (data.padding.bottom == 0.0 &&
        data.viewInsets.bottom != 0.0 &&
        maintainBottomViewPadding)
      padding = padding.copyWith(bottom: data.viewPadding.bottom);

    return LayoutBuilder(
      builder: (context, constraints) {
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
              padding: padding,
              overflowTappable: overflowTappable,
            ),
            _LeftAndRight(
              color: color,
              padding: padding,
              overflowTappable: overflowTappable,
              constraints: constraints,
            ),
          ],
        );
      },
    );
  }
}

class _TopAndBottom extends StatelessWidget {
  const _TopAndBottom({
    Key key,
    @required this.color,
    @required this.padding,
    @required this.overflowTappable,
  }) : super(key: key);

  final Color color;
  final EdgeInsets padding;
  final bool overflowTappable;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: overflowTappable,
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
  const _LeftAndRight({
    Key key,
    @required this.color,
    @required this.padding,
    @required this.overflowTappable,
    @required this.constraints,
  }) : super(key: key);

  final Color color;
  final EdgeInsets padding;
  final bool overflowTappable;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: overflowTappable,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: padding.top,
              ),
              Container(
                width: padding.left,
                height: constraints.maxHeight - padding.top - padding.bottom,
                color: color,
              ),
            ],
          ),
          Expanded(
            child: Container(
              height: 0.0,
              width: 0.0,
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: padding.top,
              ),
              Container(
                width: padding.right,
                height: constraints.maxHeight - padding.top - padding.bottom,
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
