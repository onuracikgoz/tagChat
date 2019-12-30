import 'package:flutter/cupertino.dart';
import 'package:tagchat/navitem.dart';

class BottomNavigator extends StatelessWidget {
  final TabItemName currenTabItemName;
  final ValueChanged<TabItemName> onSelectedTab;
  final Map<TabItemName, Widget> showNavigator;
  final Map<TabItemName, GlobalKey<NavigatorState>> navigatorKeys;

  const BottomNavigator(
      {Key key,
      @required this.currenTabItemName,
      @required this.onSelectedTab,
      @required this.showNavigator,
      @required this.navigatorKeys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
          items: [
            _bottomNavigationBarItem(
              tabItemName: TabItemName.Mainpage,
            ),
            _bottomNavigationBarItem(
              tabItemName: TabItemName.Hashtags,
            ),
            _bottomNavigationBarItem(
              tabItemName: TabItemName.Search,
            ),
            _bottomNavigationBarItem(
              tabItemName: TabItemName.Category,
            ),
            _bottomNavigationBarItem(
              tabItemName: TabItemName.Profile,
            )
          ],
          onTap: (index) {
            onSelectedTab(TabItemName.values[index]);
          }),
      tabBuilder: (context, index) {
        final tabIndex = TabItemName.values[index];

        return CupertinoTabView(builder: (context) {
          return showNavigator[tabIndex];
        },
        navigatorKey: navigatorKeys[tabIndex],);
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({TabItemName tabItemName}) {
    final tab = TabItemData.tabItemsMap[tabItemName];

    return BottomNavigationBarItem(
      icon: Icon(tab.icon),
      title: Text(tab.title),
    );
  }
}
