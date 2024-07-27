import 'package:flutter_test/flutter_test.dart';
import 'package:leboncoin/models/user.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';

void main() {
  group('UserService Tests', () {
    late MockUserService mockUserService;

    setUp(() {
      mockUserService = MockUserService();
    });

    test('fetchUsers returns a list of users', () async {
      // Arrange
      when(mockUserService.fetchUsers()).thenAnswer((_) async => [
        User(id: 1, nickname: 'John', token: 'token1'),
        User(id: 2, nickname: 'Doe', token: 'token2'),
      ]);

      // Act
      final users = await mockUserService.fetchUsers();

      // Assert
      expect(users, isA<List<User>>());
      expect(users.length, 2);
    });

    test('fetchLastMessage returns the last message', () async {
      // Arrange
      when(mockUserService.fetchLastMessage(any)).thenAnswer((_) async => 'Last message');

      // Act
      final message = await mockUserService.fetchLastMessage(1);

      // Assert
      expect(message, 'Last message');
    });
  });
}
