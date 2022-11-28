import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:private_upload/constants/app_constants.dart';
import 'package:private_upload/model/docmodel.dart';
import 'package:private_upload/model/filemodel.dart';
import 'package:private_upload/model/signupmodel.dart';

class PrivateProvider extends ChangeNotifier {
  Client client = Client();
  Account? account;
  late Storage storage;
  late Databases databases;
  User? _user;
  PlatformFile? _selectedfile;
  UploadedFiles? _uploadedFiles;
  List<DocModel>? _items;
  bool? _isSignedup;
  bool? _isLoggedin;

  PlatformFile? get selectedfile => _selectedfile;
  UploadedFiles? get uploadedFiles => _uploadedFiles;
  List<DocModel>? get docmodel => _items;
  User? get user => _user;
  bool? get isSignedup => _isSignedup;
  bool? get isLoggedin => _isLoggedin;

  PrivateProvider() {
    _init();
  }

  _init() {
    _isSignedup = false;
    _isLoggedin = true;
    _user = null;
    _selectedfile = null;
    _uploadedFiles = null;
    client
        .setEndpoint(Appconstants.endpoint)
        .setProject(Appconstants.projectid);
    account = Account(client);
    storage = Storage(client);
    databases = Databases(client, databaseId: Appconstants.dbid);
    if(_isLoggedin == true){
      _displayfile();
    }
    // _checklogin();
  }

  checklogin() async {
    try {
      _user = await _getaccount();
      // _isLoggedin = false;
      if (_isLoggedin == true) {
        filepicker();
      }
      // print(_isLoggedin);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future _getaccount() async {
    try {
      final res = await account?.get();
      if (res?.status != null || res?.status == true) {
        final jsondata = jsonEncode(res!.toMap());
        final json = jsonDecode(jsondata);
        print(json);
        return User.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      if (e is AppwriteException) {
        _isLoggedin = false;
      } else {
        rethrow;
      }
    }
  }

    login(String email, String password) async {
    try {
      var result = await account!.createEmailSession(
          email: email,
          password:
              password); // create a new email session with respect to the parameters provided (if an account exist, then we will be able to create a new session)
      _user = await _getaccount();
      print("user is loggedin? $_isLoggedin");
      print("current user ${result.current}");
      if (result.current == true) {
        await _displayfile();
        _isLoggedin = true;
      }
      print(_isLoggedin);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  signup(String name, String email, String password) async {
    try {
      var result = await account!.create(
          userId: "unique()", name: name, email: email, password: password);
      // print("done");
      // _isSignedup = false;
      if (result.status == true) {
        _isSignedup = true;
      } else {
        return await _getaccount();
      }
      // print(_isSignedup);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  filepicker() async {
    var result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    _selectedfile = result.files.first;
    print(_selectedfile!.path);
    _uploadedFiles = await _uploadfiles();
    createdocument();
    notifyListeners();
  }

  Future _uploadfiles() async {
    try {
      var upload = await storage.createFile(
          bucketId: Appconstants.bucketid,
          fileId: 'unique()',
          file: InputFile(
              path: _selectedfile!.path, filename: _selectedfile!.name),
          );
      print(upload.$id);
      notifyListeners();
      if (upload.$id.isNotEmpty == true) {
        var data = jsonEncode(upload.toMap());
        var jsondata = jsonDecode(data);
        return UploadedFiles.fromJson(jsondata);
      }
    } catch (e) {
      print(e);
    }
  }

  createdocument() async {
    try {
      var url =
          '${Appconstants.endpoint}/storage/buckets/${uploadedFiles!.bucketId}/files/${uploadedFiles!.id}/preview?project=${Appconstants.projectid}';
      var result = await databases.createDocument(
          collectionId: Appconstants.collectionId,
          documentId: uploadedFiles!.id!,
          data: {
            'url': url,
          },
          );
          await _displayfile();
    } catch (e) {
      rethrow;
    }
  }

  _displayfile() async {
    var result = await databases.listDocuments(
      collectionId: Appconstants.collectionId,
    );
    _items = result.documents
        .map((docmodel) => DocModel.fromJson(docmodel.data))
        .toList();
    notifyListeners();
  }
}
