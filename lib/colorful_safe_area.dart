library colorful_safe_area;

import 'package:flutter/material.dart';

class ColorfulSafeArea extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool allowOverflow;

  const ColorfulSafeArea({
    Key key,
    @required this.child,
    this.color = Colors.transparent,
    this.allowOverflow = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = data.padding;
    print(padding.top);

    return Stack(
      children: <Widget>[
        (allowOverflow) ? child : SafeArea(child: child),
        IgnorePointer(
          child: Column(
            children: <Widget>[
              Container(
                height: padding.top,
                color: color,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: padding.left,
                      color: color,
                    ),
                    Spacer(),
                    Container(
                      width: padding.right,
                      color: color,
                    ),
                  ],
                ),
              ),
              Container(
                height: padding.bottom,
                color: color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
