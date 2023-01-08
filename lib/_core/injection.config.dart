// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:tmdp_getx_mvc/services/auth_services.dart' as _i3;
import 'package:tmdp_getx_mvc/services/configuration_service.dart' as _i4;
import 'package:tmdp_getx_mvc/services/trending_items_service.dart' as _i5;
import 'package:tmdp_getx_mvc/services/user_account_service.dart' as _i6;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuthServices>(() => _i3.AuthServices());
    gh.lazySingleton<_i4.ConfigurationService>(
        () => _i4.ConfigurationService());
    gh.lazySingleton<_i5.TrendingItemsService>(
        () => _i5.TrendingItemsService());
    gh.lazySingleton<_i6.UserAccountService>(() => _i6.UserAccountService());
    return this;
  }
}
