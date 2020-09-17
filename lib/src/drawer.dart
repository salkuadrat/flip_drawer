import 'dart:math';

import 'package:curved_animation_controller/curved_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_drawer/src/alignment.dart';
import 'package:flip_drawer/src/container.dart';
import 'package:flip_drawer/src/item.dart';

class FlipDrawer extends StatefulWidget {

  /// The color to use for the drawer background. Typically this should be set
  /// along with [brightness].
  ///
  /// If this is null, then [ThemeData.primaryColor] is used.
  //final Color backgroundColor;

  /// The brightness of the drawer. Typically this is set along
  /// with [backgroundColor], [backgroundGradient].
  ///
  /// If this is null, then [ThemeData.primaryColorBrightness] is used.
  //final Brightness brightness;

  /// This is where you should attach your main application widget
  final Widget child;

  /// Custom drawer to be used when you don't want to use
  /// the default [SlideDrawerContainer] generated from [items] or [contentDrawer]
  final Widget drawer;

  /// Head drawer to be rendered before [contentDrawer]
  /// or the default generated content drawer from [items]
  final Widget headDrawer;

  /// Content drawer to be used if you don't want to use
  /// the default content drawer generated from [items]
  final Widget contentDrawer;

  /// List of [MenuItem] to be used to generate the default content drawer
  final List<MenuItem> items;

  /// Duration of the drawer sliding animation 
  /// 
  /// Default is [Duration(milliseconds: 300)]
  final Duration duration;

  /// Curve to be used for the drawer sliding animation
  final Curve curve;

  /// Duration of the drawer sliding animation in the reverse direction
  final Duration reverseDuration;

  /// Curve to be used for the drawer sliding animation in the reverse direction
  final Curve reverseCurve;

  /// Vertical alignment of content inside drawer 
  /// it can [start] from the top, or [center]
  final FlipDrawerAlignment alignment;

  /// Offset from right to calculate the end point of sliding animation
  /// 
  /// Default is 60.0
  final double offsetFromRight;

  final String title;

  final bool isAnimateMenuButton;

  const FlipDrawer({
    Key key, 
    this.items, 
    this.drawer,
    this.headDrawer, 
    this.contentDrawer,
    @required this.child,
    this.duration=const Duration(milliseconds: 250),
    this.curve=Curves.easeInOut,
    this.reverseDuration,
    this.reverseCurve,
    this.alignment,
    this.title,
    this.offsetFromRight=60.0,
    this.isAnimateMenuButton=true,
  }) : super(key: key);

  static _FlipDrawerState of(BuildContext context) =>
    context.findAncestorStateOfType<_FlipDrawerState>();

  @override
  _FlipDrawerState createState() => _FlipDrawerState();
}

class _FlipDrawerState extends State<FlipDrawer> 
  with TickerProviderStateMixin {

  bool _canBeDragged = false;
  double get _maxSlide => MediaQuery.of(context).size.width - widget.offsetFromRight;
  
  bool get _hasReverseCurve => widget.reverseCurve != null;
  bool get _hasReverseDuration => widget.reverseDuration != null;
  
  CurvedAnimationController _animation;
  CurvedAnimationController _menuAnimation;

  ThemeData get theme => Theme.of(context);

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animation.dispose();
    _menuAnimation.dispose();
    super.dispose();
  }

  _initAnimation() {
    _animation = CurvedAnimationController(
      vsync: this, duration: widget.duration, curve: widget.curve,
      reverseCurve: _hasReverseCurve ? widget.reverseCurve : widget.curve,
      reverseDuration: _hasReverseDuration ? widget.reverseDuration : widget.duration,
      debugLabel: 'FlipDrawer',
    );

    _menuAnimation = CurvedAnimationController(
      vsync: this, duration: widget.duration, curve: widget.curve,
      reverseCurve: _hasReverseCurve ? widget.reverseCurve : widget.curve,
      reverseDuration: _hasReverseDuration ? widget.reverseDuration : widget.duration,
    );

    _animation.addListener(() => setState(() {}));
    _menuAnimation.addListener(() => setState(() {}));
  }

  open() {
    _animation?.start();
    if(widget.isAnimateMenuButton) _menuAnimation?.start();
  }
  close() {
    _animation?.reverse();
    if(widget.isAnimateMenuButton) _menuAnimation?.reverse();
  }

  toggle() => _animation.isCompleted ? close() : open();

  _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animation.isDismissed;
    bool isDragCloseFromRight = _animation.isCompleted;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  _onDragUpdate(DragUpdateDetails details) {
    if(_canBeDragged) {
      double delta = details.primaryDelta / _maxSlide;
      _animation.progress += delta;
      if(widget.isAnimateMenuButton) _menuAnimation.progress += delta;
    }
  }

  _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (_animation.isDismissed || _animation.isCompleted) {
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = 
        details.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;
      _animation?.fling(velocity: visualVelocity);
      if(widget.isAnimateMenuButton) _menuAnimation?.fling(velocity: visualVelocity);

    } else if (_animation.progress < 0.5) {
      close();
    } else {
      open();
    }
  }

  Widget get _drawer => FlipDrawerContainer(
    alignment: widget.alignment,
    head: widget.headDrawer,
    content: widget.contentDrawer,
    drawer: widget.drawer,
    items: widget.items,
    paddingRight: widget.offsetFromRight,
    headPaddingRight: _animation.progress < 0.9 
      ? widget.offsetFromRight 
      : (1 - _animation.progress) * widget.offsetFromRight,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_animation.isCompleted) {
          close();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Material(
          color: theme.primaryColor,
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..translate(_maxSlide * (_animation.value - 1), 0.0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi / 2 * (1 - _animation.value)),
                  alignment: Alignment.centerRight,
                  child: _drawer,
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(_maxSlide * _animation.value, 0.0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-pi * _animation.value / 2),
                  alignment: Alignment.centerLeft,
                  child: widget.child,
                ),
              ),
              Positioned(
                top: 16.0 + MediaQuery.of(context).padding.top,
                left: _animation.value * MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.title,
                  style: Theme.of(context).primaryTextTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: 4.0 + MediaQuery.of(context).padding.top,
                left: 4.0 + _animation.value * _maxSlide,
                child: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    color: Colors.white, 
                    progress: _menuAnimation.controller,
                  ),
                  onPressed: toggle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}