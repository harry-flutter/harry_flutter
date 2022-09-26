import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @preResolve
  Future<Dio> get dio async {
    Dio dio = Dio();

    return dio;
  }
}
