import 'package:flutter_test/flutter_test.dart';
import 'package:leboncoin/models/message.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';

void main() {
  group('MessageService Tests', () {
    late MockMessageService mockMessageService;

    setUp(() {
      mockMessageService = MockMessageService();
    });

    test('fetchMessages returns a list of messages', () async {
      // Arrange
      when(mockMessageService.fetchMessages(any)).thenAnswer((_) async => [
        Message(id: 1, conversationId: 1, timestamp: 1625637849, authorId: 1, body: 'Message 1'),
        Message(id: 2, conversationId: 1, timestamp: 1625637867, authorId: 1, body: 'Message 2'),
      ]);

      // Act
      final messages = await mockMessageService.fetchMessages(1);

      // Assert
      expect(messages, isA<List<Message>>());
      expect(messages.length, 2);
    });

    test('sendMessage sends a message', () async {
      // Arrange
      when(mockMessageService.sendMessage(any, any, any)).thenAnswer((_) async => Future.value());

      // Act
      await mockMessageService.sendMessage(1, 1, 'Test message');

      // Assert
      verify(mockMessageService.sendMessage(1, 1, 'Test message')).called(1);
    });
  });
}
