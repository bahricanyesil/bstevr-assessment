import 'package:flutter/material.dart';

import '../../core/core_shelf.dart';
import 'components/components_shelf.dart';

class SpeedPrototypingScreen extends StatefulWidget {
  const SpeedPrototypingScreen({Key? key}) : super(key: key);

  @override
  _SpeedPrototypingScreenState createState() => _SpeedPrototypingScreenState();
}

class _SpeedPrototypingScreenState extends State<SpeedPrototypingScreen> {
  /// To control whether the user tried to exit the app.
  bool triedExit = false;

  /// Information that will be given to the [CircleComponent] widgets.
  List<dynamic> circleComponents = [
    {"widget": '71°', "bottomText": '20%'},
    {"widget": Icons.lock_open_outlined, "bottomText": 'Front Door Unlocked'},
    {"widget": Icons.garage_outlined, "bottomText": 'Garage Door Open'},
    {"widget": Icons.light_outlined, "bottomText": '3 Lights On'},
    {"widget": Icons.kitchen_outlined, "bottomText": 'Kitchen is Clean'},
  ];

  /// List contains the [BottomNavigationBar] items.
  List<BottomNavigationBarItem> bottomItems = [];

  /// Selected value of the [BottomNavigationBar]
  int selectedVal = 0;

  @override
  Widget build(BuildContext context) {
    bottomItems = [
      getBottomItem(Icons.home, 'Home'),
      getBottomItem(Icons.square_foot, 'Rooms'),
      getBottomItem(Icons.alarm, 'Automation')
    ];
    return WillPopScope(
      onWillPop: customOnWillPop,
      child: SafeArea(
        child: getScaffold(),
      ),
    );
  }

  Widget getScaffold() {
    return Scaffold(
      bottomNavigationBar: getBottomBar(),
      appBar: getAppBar(),
      body: LayoutBuilder(builder: getColumn),
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget getColumn(BuildContext context, BoxConstraints constraints) {
    return Padding(
      padding: context.leftMedHigh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getColumnChildren(),
      ),
    );
  }

  /// Returns the children of the column as a list of widgets.
  /// It contains [Spacer] and [Expanded] widgets for the purpose of responsiveness.
  /// [SizedBox] widgets exist to give a space between the main widgets. Their heights are controlled dynamically.
  List<Widget> getColumnChildren() {
    return [
      const Spacer(),
      Expanded(flex: 3, child: myHomeText()),
      SizedBox(height: context.height * 2),
      Expanded(flex: 8, child: circleList()),
      SizedBox(height: context.height * 2),
      Expanded(flex: 2, child: getTitle('Favorite Scenes')),
      Expanded(flex: 10, child: sceneList()),
      Expanded(flex: 2, child: getTitle('Favorite Accessories')),
      Expanded(flex: 16, child: accessoryList()),
      const Spacer(),
    ];
  }

  Widget myHomeText() {
    return AutoSizeText(
      'My Home',
      style: context.headline1.copyWith(color: Colors.white),
    );
  }

  /// The list of [CircleComponent] that is displayed in one row with a [ListView], scrolling horizontally.
  Widget circleList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: circleComponents.length,
      itemBuilder: getListItem,
      physics: const BouncingScrollPhysics(),
    );
  }

  /// The list of [FavoriteSceneItem] that is displayed in two row with a [GridView], scrolling horizontally.
  Widget sceneList() {
    return Padding(
      padding: context.verticalLow,
      child: GridView.count(
        primary: false,
        crossAxisSpacing: context.height,
        mainAxisSpacing: context.width * 3,
        crossAxisCount: 2,
        physics: const BouncingScrollPhysics(),
        childAspectRatio: 1 / 4,
        scrollDirection: Axis.horizontal,
        children: gridViewChildren(),
      ),
    );
  }

  /// The list of [FavoriteSceneItem] that is displayed in three column with a [GridView], scrolling vertically.
  /// Because of the time limit, it uses the same elements with [sceneList].
  Widget accessoryList() {
    // ignore: omit_local_variable_types
    List<Widget> children = gridViewChildren();
    children.addAll(gridViewChildren());
    return Padding(
      padding: context.verticalLow.copyWith(right: context.medHighWidth),
      child: GridView.count(
        primary: false,
        crossAxisSpacing: context.height,
        mainAxisSpacing: context.width * 3,
        crossAxisCount: 3,
        physics: const BouncingScrollPhysics(),
        childAspectRatio: 10 / 11,
        scrollDirection: Axis.vertical,
        children: children,
      ),
    );
  }

  /// Returns the children of the grid view lists.
  /// For the experimental purposes contains a constant data for now.
  List<Widget> gridViewChildren() {
    return <Widget>[
      const FavoriteSceneItem(
          selected: true, icon: Icons.home, text: 'I\'m Home'),
      const FavoriteSceneItem(
          selected: false, icon: Icons.directions_walk, text: 'I\'m Leaving'),
      const FavoriteSceneItem(
          selected: false, icon: Icons.light_mode, text: 'Good Morning'),
      const FavoriteSceneItem(
          selected: false, icon: Icons.dark_mode, text: 'Good Night'),
    ];
  }

  Widget getTitle(String text) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: AutoSizeText(
        text,
        style: context.headline4.copyWith(color: Colors.white),
      ),
    );
  }

  /// Get the items of the circular list from the [circleComponents] list.
  /// Creates the corresponding [CircleComponent].
  Widget getListItem(BuildContext context, int index) {
    Widget childWidget;
    if (circleComponents[index]['widget'] is String) {
      childWidget = getListText(circleComponents[index]['widget']);
    } else if (circleComponents[index]['widget'] is IconData) {
      childWidget = getListIcon(circleComponents[index]['widget']);
    } else {
      childWidget = Container();
    }
    return Container(
      margin: context.rightLow,
      width: context.width * 20,
      child: CircleComponent(
        childWidget: childWidget,
        bottomText: circleComponents[index]['bottomText'],
      ),
    );
  }

  Widget appBarIcon(IconData icon) {
    return Icon(
      icon,
      color: Colors.white,
      size: context.width * 8,
    );
  }

  Widget getListIcon(IconData icon) {
    return Icon(
      icon,
      color: Colors.green,
      size: context.width * 8,
    );
  }

  Widget getListText(String text) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: context.lowEdgeInsets,
        child: Text(
          text,
          style: context.headline3
              .copyWith(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Custom On Will Pop function to avoid directly closing the app when user clicked the back button.
  Future<bool> customOnWillPop() async {
    triedExit = !triedExit;
    if (!triedExit) return true;
    return false;
  }

  /// [BottomNavigationBar] object with custom settings and [bottomItems].
  BottomNavigationBar getBottomBar() {
    return BottomNavigationBar(
      items: bottomItems,
      selectedLabelStyle: const TextStyle(color: Colors.orange),
      selectedItemColor: Colors.orange,
      onTap: bottomTap,
      currentIndex: selectedVal,
    );
  }

  BottomNavigationBarItem getBottomItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: Colors.grey),
      activeIcon: Icon(
        icon,
        color: Colors.orangeAccent,
        size: context.width * 7.5,
      ),
      label: label,
    );
  }

  /// Creates the [DefaultAppBar] widget with custom settings.
  DefaultAppBar getAppBar() {
    return DefaultAppBar(size: context.height * 8, children: [
      appBarIcon(Icons.home),
      IconButton(
        icon: appBarIcon(Icons.add),
        onPressed: () => NavigationService.instance
            .navigateToPage(path: NavigationConstants.coinDetector),
      ),
    ]);
  }

  void bottomTap(int val) {
    setState(() {
      selectedVal = val;
    });
  }
}
