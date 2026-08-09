import 'package:flyful_farms/core/api/api_client.dart';
import 'package:flyful_farms/core/api/endpoints.dart';
import 'package:flyful_farms/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    return await apiClient.post(ApiEndpoints.login, data: data);
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    return await apiClient.post(ApiEndpoints.register, data: data);
  }

  Future<Map<String, dynamic>> forgotPassword(Map<String, dynamic> data) async {
    return await apiClient.post(ApiEndpoints.forgotPassword, data: data);
  }

  Future<void> logout() async {
    await apiClient.post(ApiEndpoints.logout);
  }

  Future<UserModel> getCurrentUser() async {
    final response = await apiClient.get(ApiEndpoints.profile);
    return UserModel.fromJson(
      Map<String, dynamic>.from(response['data'] as Map<String, dynamic>),
    );
  }

  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final response = await apiClient.put(ApiEndpoints.updateProfile, data: data);
    return UserModel.fromJson(
      Map<String, dynamic>.from(response['data'] as Map<String, dynamic>),
    );
  }
}
