import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

void main() {
  group('Currency Fields Integration Tests', () {
    test('PersonalInformationModel deserializes currency field', () {
      final json = {
        "id": 168,
        "name": "Cali",
        "country": "Egypt",
        "number": "+200118156789",
        "email": "a@a.com",
        "wantsEmails": true,
        "jobPostingCredits": null,
        "currency": "EGP"
      };

      final model = PersonalInformationModel.fromJson(json);
      expect(model.currency, equals('EGP'));
    });

    test('PersonalInformationModel serializes currency field', () {
      const model = PersonalInformationModel(
        id: 168,
        name: "Cali",
        country: "Egypt",
        number: "+200118156789",
        email: "a@a.com",
        wantsEmails: true,
        currency: "EUR",
      );

      final json = model.toJson();
      expect(json['currency'], equals('EUR'));
    });

    test('JobModel deserializes currency field', () {
      final json = {
        "title": "Clinical A research Assistant",
        "description": "Healthcare facility seeking a Clinical Research Assistant to support patient care.",
        "id": 61263,
        "type": "TEMPORARY",
        "location": "Port Patrick",
        "startDate": "30-03-2026",
        "amount": 10302.24,
        "currency": "EGP",
        "salary": "YEARLY",
        "duration": 7,
        "status": "OPEN",
        "numOfPositions": 1,
        "workArrangement": "HYBRID",
        "jobposterId": 100,
        "jobposterName": "Riya Senn",
      };

      final model = JobModel.fromJson(json);
      expect(model.currency, equals('EGP'));
    });

    test('JobModel serializes currency field', () {
      const model = JobModel(
        title: "Clinical A research Assistant",
        description: "Healthcare facility seeking a Clinical Research Assistant.",
        id: 61263,
        type: "TEMPORARY",
        location: "Port Patrick",
        startDate: "30-03-2026",
        amount: 10302.24,
        currency: "USD",
        salary: "YEARLY",
        status: "OPEN",
        numOfPositions: 1,
        jobposterId: 100,
        jobposterName: "Riya Senn",
      );

      final json = model.toJson();
      expect(json['currency'], equals('USD'));
    });
  });
}
