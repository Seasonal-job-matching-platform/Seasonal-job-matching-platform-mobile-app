import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/services/profile_screen_services/feedback_service.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';

final feedbackProvider = AsyncNotifierProvider<FeedbackNotifier, void>(() {
  return FeedbackNotifier();
});

class FeedbackNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Return void to initialize as AsyncData(null)
  }

  Future<void> submitFeedback({
    required String title,
    required String body,
    required bool anonymous,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      String? userEmail;

      if (!anonymous) {
        final personalInfoState = ref.read(personalInformationProvider);
        userEmail = personalInfoState.value?.email;
        if (userEmail == null) {
          throw Exception('Unable to retrieve user email. Please submit anonymously.');
        }
      }

      await ref.read(feedbackServiceProvider).submitFeedback(
        title: title,
        body: body,
        userEmail: userEmail,
      );
    });
  }
}
