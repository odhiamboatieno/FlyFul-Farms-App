class Env {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000/api/v1',
  );
  static const String appName = 'Flyful Farms';
  static const String appVersion = '1.0.0';
}
