import 'package:flutter/material.dart';
import 'package:flip_drawer/flip_drawer.dart';

void main() {
  runApp(App());
}

enum FlipDrawerExampleType {
  BASIC,
  ICON,
  HEAD_DRAWER,
  CONTENT_DRAWER,
  HEAD_CONTENT_DRAWER,
  FULL_DRAWER,
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Key _appKey = UniqueKey();
  FlipDrawerExampleType type = FlipDrawerExampleType.BASIC;
  String _title = 'Flip Drawer Demo';

  bool get _isBasic => type == FlipDrawerExampleType.BASIC;
  bool get _isIcon => type == FlipDrawerExampleType.ICON;
  bool get _isHead => type == FlipDrawerExampleType.HEAD_DRAWER;
  bool get _isContent => type == FlipDrawerExampleType.CONTENT_DRAWER;
  bool get _isHeadContent => type == FlipDrawerExampleType.HEAD_CONTENT_DRAWER;
  bool get _isFullDrawer => type == FlipDrawerExampleType.FULL_DRAWER;

  List<MenuItem> get _items => [
        MenuItem('Basic',
            onTap: () => _changeType(FlipDrawerExampleType.BASIC)),
        MenuItem('With Icon',
            onTap: () => _changeType(FlipDrawerExampleType.ICON)),
        MenuItem('Custom Header',
            onTap: () => _changeType(FlipDrawerExampleType.HEAD_DRAWER)),
        MenuItem('Custom Content',
            onTap: () => _changeType(FlipDrawerExampleType.CONTENT_DRAWER)),
        MenuItem('Header and Content',
            onTap: () =>
                _changeType(FlipDrawerExampleType.HEAD_CONTENT_DRAWER)),
        MenuItem('Full Drawer',
            onTap: () => _changeType(FlipDrawerExampleType.FULL_DRAWER)),
      ];

  List<MenuItem> get _itemsIcon => [
        MenuItem('Basic',
            icon: Icons.rss_feed,
            onTap: () => _changeType(FlipDrawerExampleType.BASIC)),
        MenuItem('With Icon',
            icon: Icons.favorite_border,
            onTap: () => _changeType(FlipDrawerExampleType.ICON)),
        MenuItem('Custom Header',
            icon: Icons.map,
            onTap: () => _changeType(FlipDrawerExampleType.HEAD_DRAWER)),
        MenuItem('Custom Content',
            icon: Icons.person_outline,
            onTap: () => _changeType(FlipDrawerExampleType.CONTENT_DRAWER)),
        MenuItem('Header and Content',
            icon: Icons.alarm,
            onTap: () =>
                _changeType(FlipDrawerExampleType.HEAD_CONTENT_DRAWER)),
        MenuItem('Full Drawer',
            icon: Icons.settings,
            onTap: () => _changeType(FlipDrawerExampleType.FULL_DRAWER)),
      ];

  _changeType(type) {
    if (this.type != type)
      setState(() {
        this.type = type;
        _appKey = UniqueKey();
      });
  }

  Widget get _home {
    if (_isBasic) return _basic;
    if (_isIcon) return _icon;
    if (_isHead) return _head;
    if (_isContent) return _content;
    if (_isHeadContent) return _headContent;
    if (_isFullDrawer) return _fullDrawer;
    return _basic;
  }

  Widget get _basic => FlipDrawer(
        title: _title,
        child: HomePage(),
        items: _items,
      );

  Widget get _icon => FlipDrawer(
        title: _title,
        child: HomePage(),
        items: _itemsIcon,
      );

  Widget get _head => FlipDrawer(
        title: _title,
        child: HomePage(),
        headDrawer: Image.asset('boys.png'),
        alignment: FlipDrawerAlignment.start,
        items: _itemsIcon,
      );

  Widget get _content => FlipDrawer(
        title: _title,
        child: HomePage(),
        contentDrawer: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              for (var item in _itemsIcon)
                ListTile(
                  title: Text(item.title),
                  leading: Icon(item.icon),
                  onTap: item.onTap,
                ),
            ],
          ),
        ),
      );

  Widget get _headContent => FlipDrawer(
        title: _title,
        child: HomePage(),
        alignment: FlipDrawerAlignment.start,
        headDrawer: Image.asset('boys.png'),
        contentDrawer: Container(
          padding: EdgeInsets.only(left: 10, top: 18),
          child: Column(
            children: [
              for (var item in _itemsIcon)
                ListTile(
                  title: Text(item.title),
                  leading: Icon(item.icon),
                  onTap: item.onTap,
                ),
            ],
          ),
        ),
      );

  Widget get _fullDrawer => FlipDrawer(
        title: _title,
        child: HomePage(),
        offsetFromRight: 80,
        isAnimateMenuButton: false,
        drawer: Container(
          color: Colors.teal,
          padding: EdgeInsets.symmetric(vertical: 36, horizontal: 15),
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var item in _items)
                  ListTile(
                    title: Text(item.title),
                    onTap: item.onTap,
                  ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: _appKey,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _home,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          //title: Text('Flip Drawer Demo'),
          //leading: Container(),
          ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
