import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItemName { Mainpage, Hashtags, Search, Category,Profile }

class TabItemData {
  TabItemData(this.title, this.icon);

  final String title;
  final IconData icon;

 static Map <TabItemName, TabItemData> tabItemsMap = {
TabItemName.Mainpage: TabItemData('Anasayfa',Icons.home),
TabItemName.Profile: TabItemData('Profil',Icons.supervised_user_circle),
TabItemName.Hashtags: TabItemData('Hashtags',Icons.whatshot),
TabItemName.Category: TabItemData('Kategori',Icons.language),
TabItemName.Search: TabItemData('Search',Icons.search)

 } ;
}
