import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthModule {
  @preResolve
  Future<Box<dynamic>> get authBox async {
    return await Hive.openBox('auth');
  }
}
