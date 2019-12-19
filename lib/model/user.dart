class User {

  final String userID;
  String email;
  String userName;
  String profilUrl;
  DateTime createdAt;
  DateTime updateAt;
  int seviye;
User ({this.userID});

Map<String, dynamic> toMap(){
return {

  'userID':userID,
  'email':email,
  'userName':userName??'',
  'profilUrl':profilUrl ?? '',
  'createdAt':createdAt??'',
  'updateAt':updateAt??'',
  'seviye':seviye?? 1,

  };



}

}