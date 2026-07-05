import 'package:intl/intl.dart';
import 'package:job_seeker/l10n/app_localizations.dart';

enum JobType {
  fullTime,
  partTime,
  freelance,
  contract,
  temporary,
  volunteer,
  internship,
  unknown;

  static JobType fromString(String? typeStr) {
    if (typeStr == null || typeStr.isEmpty) return JobType.unknown;
    final normalized = typeStr.toLowerCase().replaceAll('_', '');
    if (normalized.contains('fulltime')) return JobType.fullTime;
    if (normalized.contains('parttime')) return JobType.partTime;
    if (normalized.contains('freelance')) return JobType.freelance;
    if (normalized.contains('contract')) return JobType.contract;
    if (normalized.contains('temporary') || normalized.contains('temp')) return JobType.temporary;
    if (normalized.contains('volunteer')) return JobType.volunteer;
    if (normalized.contains('internship') || normalized.contains('intern')) return JobType.internship;
    return JobType.unknown;
  }

  String getEnglishLabel() {
    switch (this) {
      case JobType.fullTime:
        return 'Full Time';
      case JobType.partTime:
        return 'Part Time';
      case JobType.freelance:
        return 'Freelance';
      case JobType.contract:
        return 'Contract';
      case JobType.temporary:
        return 'Temporary';
      case JobType.volunteer:
        return 'Volunteer';
      case JobType.internship:
        return 'Internship';
      case JobType.unknown:
        return 'Unknown';
    }
  }

  String getLocalizedLabel(AppLocalizations l10n) {
    switch (this) {
      case JobType.fullTime:
        return l10n.fullTime;
      case JobType.partTime:
        return l10n.partTime;
      case JobType.freelance:
        return l10n.freelance;
      case JobType.contract:
        return l10n.contract;
      case JobType.temporary:
        return l10n.temporary;
      case JobType.volunteer:
        return l10n.volunteer;
      case JobType.internship:
        return l10n.internship;
      case JobType.unknown:
        return l10n.notSet;
    }
  }
}

enum ApplicationStatus {
  pending,
  accepted,
  rejected,
  interview,
  interviewScheduled,
  submitted,
  closed,
  open,
  unknown;

  static ApplicationStatus fromString(String? statusStr) {
    if (statusStr == null || statusStr.isEmpty) return ApplicationStatus.unknown;
    final normalized = statusStr.toLowerCase();
    if (normalized.contains('pending')) return ApplicationStatus.pending;
    if (normalized.contains('accepted') || normalized.contains('approved')) return ApplicationStatus.accepted;
    if (normalized.contains('rejected') || normalized.contains('declined')) return ApplicationStatus.rejected;
    if (normalized.contains('interview_scheduled')) return ApplicationStatus.interviewScheduled;
    if (normalized.contains('interview')) return ApplicationStatus.interview;
    if (normalized.contains('submitted')) return ApplicationStatus.submitted;
    if (normalized.contains('closed')) return ApplicationStatus.closed;
    if (normalized.contains('open')) return ApplicationStatus.open;
    return ApplicationStatus.unknown;
  }

  String getEnglishLabel() {
    switch (this) {
      case ApplicationStatus.pending:
        return 'Pending';
      case ApplicationStatus.accepted:
        return 'Accepted';
      case ApplicationStatus.rejected:
        return 'Rejected';
      case ApplicationStatus.interview:
        return 'Interview';
      case ApplicationStatus.interviewScheduled:
        return 'Interview Scheduled';
      case ApplicationStatus.submitted:
        return 'Submitted';
      case ApplicationStatus.closed:
        return 'Closed';
      case ApplicationStatus.open:
        return 'Open';
      case ApplicationStatus.unknown:
        return 'Unknown';
    }
  }

  String getLocalizedLabel(AppLocalizations l10n) {
    switch (this) {
      case ApplicationStatus.pending:
        return l10n.statusPending;
      case ApplicationStatus.accepted:
        return l10n.statusAccepted;
      case ApplicationStatus.rejected:
        return l10n.statusRejected;
      case ApplicationStatus.interview:
        return l10n.statusInterview;
      case ApplicationStatus.interviewScheduled:
        return l10n.statusInterviewScheduled;
      case ApplicationStatus.submitted:
        return l10n.statusSubmitted;
      case ApplicationStatus.closed:
        return l10n.statusClosed;
      case ApplicationStatus.open:
        return l10n.statusOpen;
      case ApplicationStatus.unknown:
        return l10n.notSet;
    }
  }
}

class TranslationUtils {
  /// Translates application status strings like 'PENDING', 'ACCEPTED', etc.
  static String translateStatus(String? apiStatus, AppLocalizations l10n) {
    if (apiStatus == null || apiStatus.isEmpty) return l10n.notSet;
    final statusEnum = ApplicationStatus.fromString(apiStatus);
    if (statusEnum == ApplicationStatus.unknown) {
      return apiStatus;
    }
    return statusEnum.getLocalizedLabel(l10n);
  }

  /// Translates job type strings like 'FULL_TIME', 'PART_TIME', etc.
  static String translateJobType(String? apiJobType, AppLocalizations l10n) {
    if (apiJobType == null || apiJobType.isEmpty) return l10n.notSet;
    final typeEnum = JobType.fromString(apiJobType);
    if (typeEnum == JobType.unknown) {
      return apiJobType;
    }
    return typeEnum.getLocalizedLabel(l10n);
  }

  /// Translates salary type strings like 'HOURLY', 'MONTHLY', etc.
  static String translateSalaryType(String? apiSalaryType, AppLocalizations l10n) {
    if (apiSalaryType == null || apiSalaryType.isEmpty) return l10n.notSet;

    final type = apiSalaryType.toLowerCase();

    if (type.contains('hour')) return l10n.hourly;
    if (type.contains('month')) return l10n.monthly;
    if (type.contains('year')) return l10n.yearly;

    // Fallback if not mapped
    return apiSalaryType;
  }

  /// Formats currency amount using currency name/code, handling LTR and RTL.
  static String formatCurrency(num amount, String currencyCode, bool isRtl) {
    final formattedAmount = NumberFormat('#,##0', 'en_US').format(amount);
    if (isRtl) {
      // Use RTL Marks (\u200F) to ensure amount is read first in RTL context
      return '\u200F$formattedAmount \u200F$currencyCode';
    }
    return '$formattedAmount $currencyCode';
  }
}
