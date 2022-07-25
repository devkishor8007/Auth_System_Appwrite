import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:auth_system/data/model/user.dart';
import 'package:auth_system/res/appwriteConstant.dart';

class AuthAppwrite {
  static AuthAppwrite? _instance;

  late Client _client;
  late Account _account;

  AuthAppwrite._internal() {
    _client = Client(endPoint: AppwriteConstant.endpontId)
        .setProject(AppwriteConstant.projectId)
        .setSelfSigned();
    _account = Account(_client);
  }

  static AuthAppwrite? get instance {
    if (_instance == null) return _instance = AuthAppwrite._internal();
    return _instance;
  }

  Future signup({
    required String userID,
    required String name,
    required String email,
    required String password,
  }) async {
    return _account.create(
      userId: userID.isEmpty ? 'unique()' : userID,
      name: name,
      email: email,
      password: password,
    );
  }

  Future login({
    required String email,
    required String password,
  }) {
    return _account.createEmailSession(email: email, password: password);
  }

  Future<UserData> knowUserLogin() async {
    User res = await _account.get();
    return UserData.fromMap(res);
  }

  Future logout() async {
    await _account.deleteSessions();
  }

  Future<UserData> updateName({
    required String name,
  }) async {
    User res = await _account.updateName(name: name);
    return UserData.fromMap(res);
  }

  Future<UserData> updateEmail({
    required String email,
    required String password,
  }) async {
    User res = await _account.updateEmail(email: email, password: password);
    return UserData.fromMap(res);
  }

  Future<UserData> updatePassword({
    required String password,
    required String oldpw,
  }) async {
    User res = await _account.updatePassword(
      password: password,
      oldPassword: oldpw,
    );
    return UserData.fromMap(res);
  }
}
