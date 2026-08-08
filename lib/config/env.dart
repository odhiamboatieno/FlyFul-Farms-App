class Env {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://app.flyfulfarms.com/api/v1',
  );
  static const String appName = 'Flyful Farms';
  static const String appVersion = '1.0.0';
}
