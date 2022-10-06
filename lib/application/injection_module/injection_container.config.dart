// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../src/repository/wizard_world_repository.dart' as _i6;
import '../../src/wizard_world_api_client.dart' as _i5;
import '../navigation/app_router.gr.dart' as _i3;
import '../router_module/router_module.dart' as _i7;
import 'dio_module.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final routerModule = _$RouterModule();
  final dioModule = _$DioModule();
  gh.singleton<_i3.AppRouter>(routerModule.router);
  await gh.factoryAsync<_i4.Dio>(
    () => dioModule.dio,
    preResolve: true,
  );
  gh.factory<_i5.WizardWorldApiClient>(
      () => _i5.WizardWorldApiClient(dio: get<_i4.Dio>()));
  gh.factory<_i6.WizardWorldRepository>(() => _i6.WizardWorldRepository(
      wizardWorldApiClient: get<_i5.WizardWorldApiClient>()));
  return get;
}

class _$RouterModule extends _i7.RouterModule {}

class _$DioModule extends _i8.DioModule {}
