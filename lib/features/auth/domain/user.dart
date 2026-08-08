class User {
  final String id;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? village;
  final String? county;
  final String? avatar;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.role,
    this.village,
    this.county,
    this.avatar,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          phone == other.phone &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          role == other.role;

  @override
  int get hashCode => Object.hash(id, email, phone, firstName, lastName, role);

  factory User.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final id = rawId is int ? rawId.toString() : rawId as String? ?? '';
    return User(
      id: id,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      firstName: json['firstName'] as String? ?? json['first_name'] as String?,
      lastName: json['lastName'] as String? ?? json['last_name'] as String?,
      role: json['role'] as String?,
      village: json['village'] as String?,
      county: json['county'] as String?,
      avatar: json['avatar'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'phone': phone,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'village': village,
        'county': county,
        'avatar': avatar,
        'is_active': isActive,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
