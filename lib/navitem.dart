import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItemName { Anasayfa, Hashtags, Kategori, Profil }

class TabItemData {
  TabItemData(this.title, this.icon);

  final String title;
  final IconData icon;

 static Map <TabItemName, TabItemData> tabItemsMap = {
TabItemName.Anasayfa: TabItemData('Anasayfa',Icons.home),
TabItemName.Profil: TabItemData('Profil',Icons.supervised_user_circle),
TabItemName.Hashtags: TabItemData('Hashtags',Icons.whatshot),
TabItemName.Kategori: TabItemData('Kategori',Icons.category)

 } ;
}
