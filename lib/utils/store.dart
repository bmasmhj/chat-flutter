import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Store {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveUserData(
      String id, String name, String email, String token) async {
    await _secureStorage.write(key: 'id', value: id);
    await _secureStorage.write(key: 'name', value: name);
    await _secureStorage.write(key: 'email', value: email);
    await _secureStorage.write(key: 'token', value: token);
  }
}
