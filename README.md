# FlipDrawer

An easy way to use a drawer with cool flipping animation.

![](example.gif)

## Getting Started

You should add dependency in your flutter project.

```yaml
dependencies:
  flip_drawer: ^1.0.1
```

Or reference the git repo directly:

```yaml
dependencies:
  flip_drawer:
    git: https://github.com/salkuadrat/flip_drawer.git
```

Then run `flutter packages upgrade` or update your packages in IntelliJ.

## Example Project

You can see the `example` folder to learn many different ways to use FlipDrawer in your app.

## How To Use

As usual, you need to import the package.

```
import 'package:flip_drawer/flip_drawer.dart';
```

Then wrap your app home page with FlipDrawer. 

To use the basic FlipDrawer, you need to define title and items (List of MenuItem) to generate menu in your drawer. The drawer will use your default theme color as drawer background, and theme brightness as drawer brightness.

```
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

Then you need to set your AppBar to only use a bare AppBar without title and leading. Title and menu button will be managed by FlipDrawer.

```
appBar: AppBar(),
```

### Icons

You can also use icon for your menu items.

```
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

```
home: FlipDrawer(
  title: 'Your App Title',
  alignment: SlideDrawerAlignment.start,
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

In the previous example, you use items to let the FlipDrawer generate menu in the content drawer.
You can also use any other widget as the content drawer.

```
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

If you have your own creative idea for the full widget inside the drawer, don't worry. You can use it too in your FlipDrawer by passing it to drawer. If you use custom drawer like this, make sure to use the same background color for your custom drawer as your Theme color.

```
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

You can also use custom curve and duration if you want. The default values are linear and 250ms. You can also specify curveReverse and durationReverse to change curve and duration of animation in the reverse direction.

```
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