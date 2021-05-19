import 'package:flutter/material.dart';
import 'package:flip_drawer/src/alignment.dart';
import 'package:flip_drawer/src/item.dart';

class FlipDrawerContainer extends StatelessWidget {
  final Widget? drawer;

  final Widget? head;

  final Widget? content;

  final List<MenuItem> items;

  final double paddingRight;

  final double headPaddingRight;

  /// The color to use for the background. Typically this should be set
  /// along with [brightness].
  ///
  /// If this property is null, then [ThemeData.primaryColor] is used.
  //final Color backgroundColor;

  /// The brightness of the app bar's material. Typically this is set along
  /// with [backgroundColor], [backgroundGradient].
  ///
  /// If this property is null, then [ThemeData.primaryColorBrightness] is used.
  //final Brightness brightness;

  /// Vertical alignment of content inside [SlideDrawerContainer]
  /// it can [start] from the top, or [center]
  final FlipDrawerAlignment? alignment;

  bool get _hasItems => items.isNotEmpty;
  bool get _hasDrawer => drawer != null;
  bool get _hasHead => head != null;
  bool get _hasContent => content != null;

  FlipDrawerContainer({
    Key? key,
    this.drawer,
    this.head,
    this.content,
    this.items = const [],
    //this.brightness,
    //this.backgroundColor,
    this.alignment,
    this.paddingRight = 0.0,
    this.headPaddingRight = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    FlipDrawerAlignment? _alignment = alignment;

    if (_alignment == null) {
      _alignment =
          _hasHead ? FlipDrawerAlignment.start : FlipDrawerAlignment.center;
    }

    bool _isAlignTop = _alignment == FlipDrawerAlignment.start;

    double _width = MediaQuery.of(context).size.width;
    double _scale = (_width - headPaddingRight) / _width;

    return Material(
      child: _hasDrawer
          ? drawer
          : Container(
              decoration: BoxDecoration(color: theme.primaryColor),
              child: SafeArea(
                child: Theme(
                  data: ThemeData(brightness: theme.primaryColorBrightness),
                  child: Column(
                    mainAxisAlignment: _isAlignTop
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_hasHead)
                        Transform(
                          transform: Matrix4.identity()
                            ..scale(_scale, 1.0, 1.0),
                          child: head,
                        ),
                      if (_hasContent)
                        Container(
                          margin: EdgeInsets.only(right: paddingRight),
                          child: content,
                        ),
                      if (!_hasContent && _hasItems)
                        for (MenuItem item in items)
                          Container(
                            margin: EdgeInsets.only(right: paddingRight),
                            child: MenuItemWidget(item: item),
                          ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;

  MenuItemWidget({Key? key, required this.item}) : super(key: key);

  Widget? get _leading {
    if (item.hasLeading) return item.leading!;
    if (item.hasIcon) return Icon(item.icon);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _leading,
      contentPadding: EdgeInsets.only(left: _leading == null ? 24 : 16),
      title: Text(item.title),
      onTap: item.onTap,
    );
  }
}
