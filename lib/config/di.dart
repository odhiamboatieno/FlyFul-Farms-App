import 'package:get_it/get_it.dart';
import 'package:flyful_farms/core/api/api_client.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/network/connectivity.dart';
import 'package:flyful_farms/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flyful_farms/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>(), getIt<FlutterSecureStorage>()),
  );

  getIt.registerFactory<BatchProvider>(
    () => BatchProvider(getIt<AppDatabase>().batchDao, getIt<AppDatabase>().syncDao),
  );
}

ApiClient get apiClient => getIt<ApiClient>();
AppDatabase get database => getIt<AppDatabase>();
NetworkInfo get networkInfo => getIt<NetworkInfo>();
AuthService get authService => getIt<AuthService>();
FlutterSecureStorage get secureStorage => getIt<FlutterSecureStorage>();
