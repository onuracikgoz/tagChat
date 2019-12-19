import 'package:flutter/cupertino.dart';
import 'package:tagchat/navitem.dart';

class BottomNavigator extends StatelessWidget {
  final TabItemName currenTabItemName;
  final ValueChanged<TabItemName> onSelectedTab;

  const BottomNavigator(
      {Key key, @required this.currenTabItemName, @required this.onSelectedTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _bottomNavigationBarItem(
            tabItemName: TabItemName.Anasayfa,
          ),
          _bottomNavigationBarItem(
            tabItemName: TabItemName.Hashtags,
          ),
          _bottomNavigationBarItem(
            tabItemName: TabItemName.Kategori,
          ),
          _bottomNavigationBarItem(
            tabItemName: TabItemName.Profil,
          ),
        ],
        onTap: (index) {
          onSelectedTab(TabItemName.values[index]);
        }
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => Container(
            child: Text('Deneme'),
          ),
        );
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
