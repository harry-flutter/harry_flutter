import 'package:injectable/injectable.dart';
import '../navigation/app_router.gr.dart';

@module
abstract class RouterModule {
  @singleton
  AppRouter get router => AppRouter();
}
