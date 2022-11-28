// import 'dart:convert';

// import 'package:dart_appwrite/dart_appwrite.dart';
// import 'package:flutter/material.dart';
// import 'package:private_upload/constants/app_constants.dart';

// import '../model/signupmodel.dart';

// class PrivateProvider extends ChangeNotifier {
//   Client client = Client();
//   Account? account;
//   Users? users;
//   Databases? databases;
//   User? _user;
//   late bool _isSignedup;

//   bool get isSignedup => _isSignedup;
//   User ? get user => _user;

//   PrivateProvider() {
//     _init();
//   }

//   _init() {
//     _isSignedup = false;
//     client
//         .setEndpoint(Appconstants.endpoint)
//         .setProject(Appconstants.projectid)
//         .setKey(Appconstants.apikey);
//     // account = Account(client);
//     users = Users(client);
//     databases = Databases(client, databaseId: "unique()");
//     checkserver();
//   }

//   // Future _getaccount() async {
//   //   try {
//   //     final res = await account?.get();
//   //     if (res?.status != null || res?.status == true) {
//   //       final jsondata = jsonEncode(res!.toMap());
//   //       final json = jsonDecode(jsondata);
//   //       print(json);
//   //       // return User.fromJson(json);
//   //       // return res;
//   //     } else {
//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     throw (e);
//   //   }
//   // }

//   checkserver() async {
//    var createaccount = await users!.create(
//         name: "name",
//         email: "test@goke.gmail",
//         password: "12345678",
//         userId: "unique()");
//             var data = jsonEncode(createaccount.toMap());
//         var jsondata = jsonDecode(data);
//         return User.fromJson(jsondata);
//   }

//   createcollection() async{
//      final result = await databases!.createCollection(
//       collectionId: '[COLLECTION_ID]',
//       name: '${User.nam}',
//       permission: 'document',
//       read: ["role:$jsondata"],
//       write: ["role:$jsondata"],
//     );
//     await databases!.create(name: "content");
//   }

//   signup(String name, String email, String password) async {
//     // try {
//     //   var createaccount = await account!.create(
//     //       userId: "unique()", name: name, email: email, password: password);
//     //   if (createaccount.status == true) {
//     //     final jsondata = jsonEncode(createaccount.toMap());
//     //     print(jsondata);
//     //     _isSignedup = true;
//     //     notifyListeners();
//     //   }
//     //   else{
//     //     return await _getaccount();
//     //   }
//     // } catch (e) {
//     //   print(e);
//     // }
//   }
// }
