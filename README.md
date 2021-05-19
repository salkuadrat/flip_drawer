# FlipDrawer

An easy way to use drawer in Flutter with cool flipping animation.

![](example.gif)

## Getting Started

Add dependency in your flutter project.

```
$ flutter pub add flip_drawer
```

or

```yaml
dependencies:
  flip_drawer: ^1.0.2
```

or

```yaml
dependencies:
  flip_drawer:
    git: https://github.com/salkuadrat/flip_drawer.git
```

Then run `flutter pub get`.

## Example Project

You can see the `example` folder to learn many different ways of using FlipDrawer in your app.


## Usage

As usual, we need to import the package.

```dart
import 'package:flip_drawer/flip_drawer.dart';
```

Then wrap the app home page with FlipDrawer. 

To use the basic FlipDrawer, you need to define title and items (List of MenuItem) to generate menu in your drawer. The drawer will use your default theme color as drawer background, and theme brightness as drawer brightness.

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      // FlipDrawer will use style from this theme
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // wrap your HomePage with FlipDrawer
      home: FlipDrawer(
        items: [
          MenuItem('Home', onTap: (){}),
          MenuItem('Project', onTap: (){}),
          MenuItem('Favourite', onTap: (){}),
          MenuItem('Profile', onTap: (){}),
          MenuItem('Setting', onTap: (){}),
        ],
        title: 'Your App Title',
        child: HomePage(),
      ),
    );
  }
}
```

Then set AppBar to only use a bare AppBar without title and leading. Title and menu button will be managed by FlipDrawer.

```dart
appBar: AppBar(),
```

### Icons

We can also use icon for menu items.

```dart
home: FlipDrawer(
  items: [
    MenuItem('Home', icon: Icons.home, onTap: (){}),
    MenuItem('Project', icon:Icons.rss_feed, onTap: (){}),
    MenuItem('Favourite', icon: Icons.favorite_border, onTap: (){}),
    MenuItem('Profile', icon: Icons.person_outline, onTap: (){}),
    MenuItem('Setting', icon: Icons.settings, onTap: (){}),
  ],
  title: 'Your App Title',
  child: HomePage(),
),
```

### Custom Head Drawer

It's advisable to set alignment to FlipDrawerAlignment.start when you use headDrawer.

```dart
home: FlipDrawer(
  title: 'Your App Title',
  alignment: FlipDrawerAlignment.start,
  headDrawer: Image.asset('boys.png'),
  items: [
    MenuItem('Home', icon: Icons.home, onTap: (){}),
    MenuItem('Project', icon:Icons.rss_feed, onTap: (){}),
    MenuItem('Favourite', icon: Icons.favorite_border, onTap: (){}),
    MenuItem('Profile', icon: Icons.person_outline, onTap: (){}),
    MenuItem('Setting', icon: Icons.settings, onTap: (){}),
  ],
  child: HomePage(),
),
```

### Custom Content Drawer

In the previous example, we use items and let the FlipDrawer generate menu in the content drawer.
But we can also use any custom widget as the content drawer.

```dart
home: FlipDrawer(
  contentDrawer: Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      children: [
        ListTile(title: 'Home', icon: Icons.home, onTap: (){}),
        ListTile(title: 'Project', icon:Icons.rss_feed, onTap: (){}),
        ListTile(title: 'Favourite', icon: Icons.favorite_border, onTap: (){}),
        ListTile(title: 'Profile', icon: Icons.person_outline, onTap: (){}),
        ListTile(title: 'Setting', icon: Icons.settings, onTap: (){}),
      ],
    ),
  ),
  title: 'Your App Title',
  child: HomePage(),
),
```

### Custom Full Drawer

If you have your own creative idea for the full widget inside the drawer, don't worry. We can use it in FlipDrawer by passing the full widget to the drawer. But make sure to use the same background color for the custom drawer as for the Theme color.

```dart
home: FlipDrawer(
  drawer: Container(
    color: Colors.teal,
    padding: EdgeInsets.symmetric(vertical: 36, horizontal: 15),
    child: Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(title: 'Home', icon: Icons.home, onTap: (){}),
          ListTile(title: 'Project', icon:Icons.rss_feed, onTap: (){}),
          ListTile(title: 'Favourite', icon: Icons.favorite_border, onTap: (){}),
          ListTile(title: 'Profile', icon: Icons.person_outline, onTap: (){}),
          ListTile(title: 'Setting', icon: Icons.settings, onTap: (){}),
        ],
      ),
    ),
  ),
  title: 'Your App Title',
  child: HomePage(),
),
```

### Others

We can also use custom curve and duration. The default values are linear and 250ms. We can specify curveReverse and durationReverse to change curve and duration of animation in the reverse direction.

```dart
home: FlipDrawer(
  curve: Curves.easeInOut,
  duration: Duration(milliseconds: 200),
  items: [
    MenuItem('Home', icon: Icons.home, onTap: (){}),
    MenuItem('Project', icon:Icons.rss_feed, onTap: (){}),
    MenuItem('Favourite', icon: Icons.favorite_border, onTap: (){}),
    MenuItem('Profile', icon: Icons.person_outline, onTap: (){}),
    MenuItem('Setting', icon: Icons.settings, onTap: (){}),
  ],
  title: 'Your App Title',
  child: HomePage(),
),
```

There it is. Have fun!!!