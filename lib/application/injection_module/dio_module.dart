import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @preResolve
  Future<Dio> get dio async {
    Dio dio = Dio(BaseOptions(
      baseUrl: dotenv.get('BASE_URL', fallback: ''),
    ));

    return dio;
  }
}
