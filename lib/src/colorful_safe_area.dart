library colorful_safe_area;

import 'dart:math';

import 'package:colorful_safe_area/src/overflow_rules.dart';
import 'package:flutter/material.dart';

class ColorfulSafeArea extends StatelessWidget {
  const ColorfulSafeArea({
    Key key,
    this.color = Colors.transparent,
    this.overflowRules = const OverflowRules.all(false),
    this.overflowTappable = false,
    this.bottom = true,
    this.left = true,
    this.top = true,
    this.right = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
    @required this.child,
  })  : assert(color != null),
        assert(overflowRules != null),
        assert(overflowTappable != null),
        assert(left != null),
        assert(top != null),
        assert(right != null),
        assert(bottom != null),
        super(key: key);

  final Color color;
  final OverflowRules overflowRules;
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
    EdgeInsets padding = _createAdjustedPadding(data);
    EdgeInsets adjustedMinimum = _createAdjustedMinimum();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            SafeArea(
              left: !overflowRules.left,
              top: !overflowRules.top,
              right: !overflowRules.right,
              bottom: !overflowRules.bottom,
              minimum: adjustedMinimum,
              maintainBottomViewPadding: maintainBottomViewPadding,
              child: child,
            ),
            _TopAndBottom(
              color: color,
              padding: padding,
              overflowTappable: overflowTappable,
              constraints: constraints,
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

  EdgeInsets _createAdjustedPadding(MediaQueryData data) {
    return EdgeInsets.only(
      left: (left) ? max(data.padding.left, minimum.left) : minimum.left,
      top: (top) ? max(data.padding.top, minimum.top) : minimum.top,
      right: (right) ? max(data.padding.right, minimum.right) : minimum.right,
      bottom:
          (bottom) ? max(data.padding.bottom, minimum.bottom) : minimum.bottom,
    );
  }

  EdgeInsets _createAdjustedMinimum() {
    return minimum.copyWith(
      left: overflowRules.left ? 0 : minimum.left,
      top: overflowRules.top ? 0 : minimum.top,
      right: overflowRules.right ? 0 : minimum.right,
      bottom: overflowRules.bottom ? 0 : minimum.bottom,
    );
  }
}

class _TopAndBottom extends StatelessWidget {
  const _TopAndBottom({
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
      child: Column(
        children: <Widget>[
          Container(
            height: padding.top,
            width: constraints.maxWidth,
            color: color,
          ),
          Spacer(),
          Container(
            height: padding.bottom,
            width: constraints.maxWidth,
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

  double get _sideHeight =>
      constraints.maxHeight - padding.top - padding.bottom;

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
                height: _sideHeight,
                color: color,
              ),
            ],
          ),
          Spacer(),
          Column(
            children: <Widget>[
              SizedBox(
                height: padding.top,
              ),
              Container(
                width: padding.right,
                height: _sideHeight,
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
