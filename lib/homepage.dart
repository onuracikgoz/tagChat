import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/bottom_navigator_class.dart';
import 'package:tagchat/categorypage_navigator.dart';
import 'package:tagchat/hashtagpage_navigator.dart';
import 'package:tagchat/homepage_navigator.dart';
import 'package:tagchat/navitem.dart';
import 'package:tagchat/profilpage_navigator.dart';
import 'package:tagchat/searchpage_navigator.dart';
import 'package:tagchat/viewmodel/chats_model.dart';

class HomePage extends StatefulWidget {
  HomePage({this.userId});

  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItemName _currentItemName = TabItemName.Mainpage;

  Map<TabItemName, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItemName.Mainpage: GlobalKey<NavigatorState>(),
    TabItemName.Hashtags: GlobalKey<NavigatorState>(),
    TabItemName.Category: GlobalKey<NavigatorState>(),
    TabItemName.Profile: GlobalKey<NavigatorState>(),
    TabItemName.Search: GlobalKey<NavigatorState>(),
  };

  Map<TabItemName, Widget> showNavigatorPage() {
    return {
      TabItemName.Mainpage: HomePageNavigator(),
      TabItemName.Profile: ProfilPageNavigator(),
      TabItemName.Hashtags: HashtagPageNavigator(),
      TabItemName.Category: CategoryPageNavigator(),
      TabItemName.Search: SearchPageNavigator(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentItemName].currentState.maybePop(),
      child: ChangeNotifierProvider(
          builder: (context)=>ChatsModel(),
          create: (context)=>ChatsModel(),
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
      ),
    );
  }
}
