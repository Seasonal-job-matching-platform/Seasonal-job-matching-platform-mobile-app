import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';

final applicationsProvider =
    AsyncNotifierProvider<ApplicationsNotifier, List<ApplicationWithJob>>(
      ApplicationsNotifier.new,
    );

class ApplicationsNotifier extends AsyncNotifier<List<ApplicationWithJob>> {
  late final ApplicationsService _service = ref.read(
    applicationsServiceProvider,
  );

  @override
  Future<List<ApplicationWithJob>> build() async {
    // Watch only user ID changes to avoid redundant requests when other profile fields (like favorites) update
    final userId = await ref.watch(
      personalInformationProvider.selectAsync((data) => data.id),
    );
    
    // Fetch all applications for this user
    final result = await _service.getApplicationsForUser(userId.toString());
    
    // Sort applications by date descending (most recent first)
    result.sort((a, b) {
      final dateAStr = a.application.appliedDate ?? a.application.createdAt;
      final dateBStr = b.application.appliedDate ?? b.application.createdAt;
      
      if (dateAStr == null && dateBStr == null) return 0;
      if (dateAStr == null) return 1; // Nulls sorted to the end
      if (dateBStr == null) return -1; // Nulls sorted to the end
      
      final dateA = DateTime.tryParse(dateAStr);
      final dateB = DateTime.tryParse(dateBStr);
      
      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1; // Unparseable sorted to the end
      if (dateB == null) return -1; // Unparseable sorted to the end
      
      return dateB.compareTo(dateA); // Descending (most recent first)
    });
    
    return result;
  }
}