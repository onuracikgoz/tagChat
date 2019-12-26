
import 'package:get_it/get_it.dart';
import 'package:tagchat/root_page.dart';
import 'package:tagchat/services/authentication.dart';
import 'package:tagchat/repository/user_repository.dart';
import 'package:tagchat/services/db_base.dart';
import 'package:tagchat/services/db_storage.dart';

GetIt locator = GetIt.instance ;

void setupLocator(){

  locator.registerLazySingleton(()=>Auth()); //firebase auth
  locator.registerLazySingleton(()=>UserRepository());  
  locator.registerLazySingleton(()=>FirestoreDBService());
  locator.registerLazySingleton(()=>FirestoreStorageService());
  locator.registerLazySingleton(()=>RootPage());
  
  



   //başka bir veritabanı ekleyebiliriz..

}