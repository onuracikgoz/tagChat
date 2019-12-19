
import 'package:get_it/get_it.dart';
import 'package:tagchat/authentication.dart';
import 'package:tagchat/repository/user_repository.dart';

GetIt locator = GetIt.instance ;

void setupLocator(){

  locator.registerLazySingleton(()=>Auth()); //firebase auth
  locator.registerLazySingleton(()=>UserRepository());


   //başka bir veritabanı ekleyebiliriz..

}