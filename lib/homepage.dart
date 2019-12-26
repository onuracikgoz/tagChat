import 'package:flutter/material.dart';
import 'package:tagchat/bottom_navigator_class.dart';
import 'package:tagchat/categorypage_navigator.dart';
import 'package:tagchat/hashtagpage_navigator.dart';
import 'package:tagchat/homepage_navigator.dart';
import 'package:tagchat/navitem.dart';
import 'package:tagchat/profilpage_navigator.dart';

class HomePage extends StatefulWidget {
  HomePage({this.userId});

  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItemName _currentItemName = TabItemName.Anasayfa;

  Map<TabItemName, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItemName.Anasayfa: GlobalKey<NavigatorState>(),
    TabItemName.Hashtags: GlobalKey<NavigatorState>(),
    TabItemName.Kategori: GlobalKey<NavigatorState>(),
    TabItemName.Profil: GlobalKey<NavigatorState>(),
  };

  Map<TabItemName, Widget> showNavigatorPage() {
    return {
      TabItemName.Anasayfa: HomePageNavigator(),
      TabItemName.Profil: ProfilPageNavigator(),
      TabItemName.Hashtags: HashtagPageNavigator(),
      TabItemName.Kategori: CategoryPageNavigator()
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentItemName].currentState.maybePop(),
      child: BottomNavigator(
        navigatorKeys: navigatorKeys,
        currenTabItemName: _currentItemName,
        onSelectedTab: (onTab) {
          if (onTab == _currentItemName) {
            navigatorKeys[onTab]
                .currentState
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentItemName = onTab;
            });
          }

          print('Seçilen Tab:' + onTab.toString());
        },
        showNavigator: showNavigatorPage(),
      ),
    );
  }
}
