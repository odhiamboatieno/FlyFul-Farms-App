import 'package:get_it/get_it.dart';
import 'package:flyful_farms/core/api/api_client.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/network/connectivity.dart';
import 'package:flyful_farms/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flyful_farms/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:flyful_farms/core/sync/sync_service.dart';
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

  getIt.registerLazySingleton<SyncService>(
    () => SyncService(
      getIt<AppDatabase>().syncDao,
      _SecureSyncStorage(getIt<FlutterSecureStorage>()),
      post: (path, data) => getIt<ApiClient>().post(path, data: data),
      get: (path, {queryParameters}) => getIt<ApiClient>().get(path, queryParameters: queryParameters),
    ),
  );
}

class _SecureSyncStorage implements SyncStorage {
  final FlutterSecureStorage _storage;

  _SecureSyncStorage(this._storage);

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);
}

ApiClient get apiClient => getIt<ApiClient>();
AppDatabase get database => getIt<AppDatabase>();
NetworkInfo get networkInfo => getIt<NetworkInfo>();
AuthService get authService => getIt<AuthService>();
FlutterSecureStorage get secureStorage => getIt<FlutterSecureStorage>();
SyncService get syncService => getIt<SyncService>();
