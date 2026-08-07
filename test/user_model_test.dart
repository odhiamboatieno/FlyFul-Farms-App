import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/features/auth/domain/user.dart';

void main() {
  group('User.fromJson', () {
    test('parses snake_case fields', () {
      final user = User.fromJson({
        'id': 1,
        'email': 'a@b.com',
        'phone': '0712345678',
        'first_name': 'Jane',
        'last_name': 'Doe',
        'role': 'farmer',
        'village': 'Katom',
        'county': 'Vihiga',
        'avatar': null,
        'is_active': true,
        'created_at': '2026-08-01T10:00:00Z',
        'updated_at': '2026-08-01T11:00:00Z',
      });

      expect(user.id, 1);
      expect(user.email, 'a@b.com');
      expect(user.firstName, 'Jane');
      expect(user.lastName, 'Doe');
      expect(user.role, 'farmer');
      expect(user.isActive, isTrue);
      expect(user.createdAt, DateTime.utc(2026, 8, 1, 10, 0, 0));
    });

    test('falls back to camelCase names', () {
      final user = User.fromJson({
        'id': 2,
        'firstName': 'John',
        'lastName': 'Smith',
      });
      expect(user.firstName, 'John');
      expect(user.lastName, 'Smith');
    });

    test('handles null created_at', () {
      final user = User.fromJson({'id': 3});
      expect(user.createdAt, isNull);
      expect(user.updatedAt, isNull);
      expect(user.isActive, isNull);
    });
  });

  group('User.toJson', () {
    test('round-trips camelCase and snake_case', () {
      final user = User(
        id: 7,
        email: 'x@y.com',
        firstName: 'Ali',
        isActive: true,
        createdAt: DateTime.utc(2026, 8, 2),
      );

      final json = user.toJson();
      expect(json['id'], 7);
      expect(json['firstName'], 'Ali');
      expect(json['is_active'], isTrue);
      expect(json['created_at'], '2026-08-02T00:00:00.000Z');
    });
  });

  group('User equality', () {
    test('equal for identical fields', () {
      final a = User(id: 1, email: 'a@b.com', firstName: 'Jane');
      final b = User(id: 1, email: 'a@b.com', firstName: 'Jane');
      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });

    test('not equal when id differs', () {
      const a = User(id: 1);
      const b = User(id: 2);
      expect(a, isNot(b));
    });
  });
}