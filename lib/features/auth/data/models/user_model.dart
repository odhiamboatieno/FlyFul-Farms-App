import 'package:flyful_farms/features/auth/domain/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    super.email,
    super.phone,
    super.firstName,
    super.lastName,
    super.role,
    super.village,
    super.county,
    super.avatar,
    super.isActive,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      User.fromJson(json) as UserModel;
}
