import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';

void main() {
  group('ApplicationModel Unit Tests', () {
    test('Parses ApplicationModel correctly with interview details when status is INTERVIEW_SCHEDULED', () {
      final json = {
        'id': 5,
        'userId': 3,
        'applicationStatus': 'INTERVIEW_SCHEDULED',
        'job': {
          'id': 101,
          'title': 'Software Engineer',
          'jobposterName': 'Acme Corp',
          'location': 'Remote',
          'type': 'Full-time',
          'salary': 'Monthly',
          'amount': 5000.0,
          'startDate': '2026-07-04',
          'status': 'Open',
          'description': 'Description',
          'requirements': [],
          'benefits': [],
          'categories': [],
          'jobposterId': 1,
          'createdAt': '2026-07-04',
          'numOfPositions': 1,
        },
        'createdAt': '2026-07-04',
        'describeYourself': 'I am a qualified software developer...',
        'interviewDate': '2026-07-10',
        'interviewTime': '14:00',
        'interviewLocation': 'https://zoom.us/j/123456789'
      };

      final model = ApplicationModel.fromJson(json);

      expect(model.id, 5);
      expect(model.applicationStatus, 'INTERVIEW_SCHEDULED');
      expect(model.interviewDate, '2026-07-10');
      expect(model.interviewTime, '14:00');
      expect(model.interviewLocation, 'https://zoom.us/j/123456789');
    });

    test('Parses ApplicationModel correctly with null interview details for status ACCEPTED', () {
      final json = {
        'id': 5,
        'userId': 3,
        'applicationStatus': 'ACCEPTED',
        'job': {
          'id': 101,
          'title': 'Software Engineer',
          'jobposterName': 'Acme Corp',
          'location': 'Remote',
          'type': 'Full-time',
          'salary': 'Monthly',
          'amount': 5000.0,
          'startDate': '2026-07-04',
          'status': 'Open',
          'description': 'Description',
          'requirements': [],
          'benefits': [],
          'categories': [],
          'jobposterId': 1,
          'createdAt': '2026-07-04',
          'numOfPositions': 1,
        },
        'createdAt': '2026-07-04',
        'describeYourself': 'I am a qualified software developer...',
        'interviewDate': null,
        'interviewTime': null,
        'interviewLocation': null
      };

      final model = ApplicationModel.fromJson(json);

      expect(model.id, 5);
      expect(model.applicationStatus, 'ACCEPTED');
      expect(model.interviewDate, isNull);
      expect(model.interviewTime, isNull);
      expect(model.interviewLocation, isNull);
    });
  });
}
