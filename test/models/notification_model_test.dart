import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/notification_model.dart';

void main() {
  group('NotificationModel Unit Tests', () {
    test('Parses NotificationModel correctly from JSON with jobTitle and createdAt', () {
      final json = {
        'id': 12,
        'message': 'Congratulations! Your application for the job "Software Engineer" has been ACCEPTED.',
        'title': 'Application Update',
        'jobTitle': 'Software Engineer',
        'recipientId': 3,
        'recipientName': 'John Doe',
        'isRead': false,
        'createdAt': '2026-07-04T20:51:09'
      };

      final model = NotificationModel.fromJson(json);

      expect(model.id, 12);
      expect(model.message, 'Congratulations! Your application for the job "Software Engineer" has been ACCEPTED.');
      expect(model.jobTitle, 'Software Engineer');
      expect(model.isRead, false);
      expect(model.createdAt, '2026-07-04T20:51:09');
    });

    test('Parses legacy NotificationModel from JSON without jobTitle or createdAt', () {
      final json = {
        'id': 5,
        'message': 'Legacy message',
        'isRead': true,
        'timestamp': '2025-01-01T00:00:00'
      };

      final model = NotificationModel.fromJson(json);

      expect(model.id, 5);
      expect(model.message, 'Legacy message');
      expect(model.jobTitle, isNull);
      expect(model.createdAt, isNull);
      expect(model.timestamp, '2025-01-01T00:00:00');
      expect(model.isRead, true);
    });
  });
}
