import 'package:flutter/material.dart';

import '../../core/core_shelf.dart';
import 'components/components_shelf.dart';

class SpeedPrototypingScreen extends StatefulWidget {
  const SpeedPrototypingScreen({Key? key}) : super(key: key);

  @override
  _SpeedPrototypingScreenState createState() => _SpeedPrototypingScreenState();
}

class _SpeedPrototypingScreenState extends State<SpeedPrototypingScreen> {
  bool triedExit = false;
  List<dynamic> circleComponents = [
    {"widget": '71°', "bottomText": '20%'},
    {"widget": Icons.lock_open_outlined, "bottomText": 'Front Door Unlocked'},
    {"widget": Icons.garage_outlined, "bottomText": 'Garage Door Open'},
    {"widget": Icons.light_outlined, "bottomText": '3 Lights On'},
    {"widget": Icons.kitchen_outlined, "bottomText": 'Kitchen is Clean'},
  ];
  List<BottomNavigationBarItem> bottomItems = [];
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

  Widget circleList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: circleComponents.length,
      itemBuilder: getListItem,
      physics: const BouncingScrollPhysics(),
    );
  }

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

  Future<bool> customOnWillPop() async {
    triedExit = !triedExit;
    if (!triedExit) return true;
    return false;
  }

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

  DefaultAppBar getAppBar() {
    return DefaultAppBar(size: context.height * 8, children: [
      appBarIcon(Icons.home),
      appBarIcon(Icons.add),
    ]);
  }

  void bottomTap(int val) {
    setState(() {
      selectedVal = val;
    });
  }
}
