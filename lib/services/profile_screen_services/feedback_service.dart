import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/endpoints.dart';

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  final dio = ref.watch(dioProvider);
  return FeedbackService(dio);
});

class FeedbackService {
  final Dio _dio;

  FeedbackService(this._dio);

  Future<void> submitFeedback({
    required String title,
    required String body,
    String? userEmail,
  }) async {
    final Map<String, dynamic> requestData = {
      'title': title,
      'body': body,
    };
    if (userEmail != null) {
      requestData['userEmail'] = userEmail;
    }

    try {
      final response = await _dio.post(
        FEEDBACK,
        data: requestData,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data['message'] ?? 'Failed to submit feedback');
      }
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'Failed to submit feedback';
      throw Exception(message);
    }
  }
}
