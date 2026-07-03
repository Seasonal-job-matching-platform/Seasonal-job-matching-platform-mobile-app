# New Features Documentation

This document describes the three new features added to the Seasonal Job Matching Platform mobile application, listing the modified files, created files, and unit tests written for verification.

---

## 1. User-Selected Currency Support

### Description
Allows users to choose their preferred currency (e.g., USD, EUR, EGP, JOD, SAR) in the Profile screen settings. The application dynamically persists the selection via a `PATCH` request to the backend profile endpoint, reactively updates salary rates shown across the app (job cards, job details, favorites, recommendations), and triggers fresh paginated job fetches to align with the chosen currency formatting.

### Files Modified
* **[endpoints.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/endpoints.dart)**: Used existing user patch routes.
* **[personal_information_model.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/models/profile_screen_models/personal_information_model.dart)**: Added `currency` field to serializable model.
* **[job_model.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/models/jobs_screen_models/job_model.dart)**: Added `currency` parsing matching server response payload schema.
* **[personal_information_notifier.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/providers/profile_screen_providers/personal_information_notifier.dart)**: Added `updateCurrency(String currency)` and synchronized it with the service layer.
* **[personal_information_service.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/services/profile_screen_services/personal_information_service.dart)**: Integrated network updates for the currency parameter.
* **[paginated_jobs_provider.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/providers/jobs_screen_providers/paginated_jobs_provider.dart)**: Listened to currency changes to reset pages and trigger fresh job lists.
* **[recommended_jobs_provider.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/providers/home_screen_providers/recommended_jobs_provider.dart)**: Listened to currency changes to reload recommended job sets.
* **[account_settings_section.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/widgets/profile_screen_widgets/account_settings_section.dart)**: Renders a dropdown selection card with supported currencies.
* **[job_crad_section.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/widgets/jobs_screen_widgets/job_crad_section.dart)**, **[job_details_screen.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/screens/Job/job_details_screen.dart)**, **[favorite_jobs_section.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/widgets/home_screen_widgets/favorite_jobs_section.dart)**: Refactored salary rates to use `NumberFormat.simpleCurrency` based on selected currency.

---

## 2. GitHub Releases OTA Update System

### Description
An update checker that requests version information from the GitHub Releases API. Compares the running version name (baseline `MAJOR.MINOR.PATCH` from `pubspec.yaml` + incrementing suffix from GitHub Actions run number) against the latest release tag. 
* **Mandatory Updates**: Blocks the application with an overlay and forces redirecting the user to download the update.
* **Optional Updates**: Prompts the user via a modal bottom sheet. If snoozed, it maintains a 24-hour timeout using `FlutterSecureStorage` and shows a notification dot badge over the Profile icon and an inline card in settings.
* Redirections point to the latest release page on GitHub.

### Files Created
* **[update_service.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/services/update_service.dart)**: Handles checking, comparisons, storage, and URL launch fallbacks.

### Files Modified
* **[buildingAPKAction.yml](file:///d:/Projects/Seasonal-job-matching-platform-mobile/buildingAPKAction.yml)**: Extracts baseline `version` from `pubspec.yaml` and appends `github.run_number` to inject unique version codes/names. Scans all commits in a push to detect `[MANDATORY]` updates automatically.
* **[main.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/main.dart)**: Triggers update check on startup (bypassed in `kDebugMode` for clean local runs).
* **[layout_screen.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/screens/layout_screen.dart)**, **[login_screen.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/screens/auth/login_screen.dart)**: Hooks up mandatory blocking overlays and optional bottom sheets.
* **[profile_screen.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/screens/Profile/profile_screen.dart)**: Integrates an adaptive `_UpdateBanner` using `LayoutBuilder` that adjusts its spacing and structure on thin screen aspect ratios.

### New Tests
* **[update_service_test.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/test/services/update_service_test.dart)**:
  * Compares SemVer versions code sequences (`isNewerVersion`).
  * Asserts major version upgrades trigger mandatory updates (`isMajorUpdate`).
  * Asserts mandatory flags parsing in names or bodies.
  * Asserts snooze state caching and expiry validations.

---

## 3. Report an Issue / Feedback Form

### Description
Provides a simple form inside the Profile screen allowing users to submit bug reports and issues. Integrates with the backend feedback POST route. Features a toggle to "Send anonymously" (omitting the email) or automatically include the user's logged-in email address in the submission payload.

### Files Created
* **[feedback_service.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/services/profile_screen_services/feedback_service.dart)**: Executes POST request to the `/feedback` route.
* **[feedback_provider.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/providers/profile_screen_providers/feedback_provider.dart)**: Riverpod `AsyncNotifier` managing loading state and email retrieval.

### Files Modified
* **[endpoints.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/endpoints.dart)**: Added the `FEEDBACK` path constant.
* **[profile_screen.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/screens/Profile/profile_screen.dart)**: Added the link button and built the custom input dialog widget (`_ReportIssueDialog`).

### New Tests
* **[feedback_service_test.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/test/services/feedback_service_test.dart)**:
  * Asserts POST body has `userEmail` when anonymous switch is false.
  * Asserts POST body omits `userEmail` when anonymous switch is true.
  * Asserts notifier manages error codes, loading spinners, and successfully initializes async states.

---

## Running the Unit Tests

You can execute the newly added test suites with the following commands:

```bash
# Run OTA Update service tests
flutter test test/services/update_service_test.dart

# Run Feedback / Issue submission tests
flutter test test/services/feedback_service_test.dart
```
