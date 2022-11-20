import 'dart:async';
import 'dart:developer';

import '../model/user.dart';

class UsersApiProvider {
  Future<List<User>> getListUsers() async {
    log('be in UsersApiProvider');
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        User(id: '01', count: 1),
        User(id: '02', count: 2),
      ];
    });
  }
}
