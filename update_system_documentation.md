# Feature Documentation: OTA Update System

The Over-The-Air (OTA) Update System allows the Android application to dynamically detect newer versions released on GitHub and guide users to install them, bypassing the Google Play Store.

---

## 1. Architecture Overview

```
 [ GitHub Actions CI ] 
        │ (compile)
        ▼
 [ GitHub Release (APK) ] ◄─── (GET /releases/latest) ─── [ Mobile Client ]
```

1. **GitHub Releases API**: The client makes a secure, unauthenticated HTTP request to:
   `https://api.github.com/repos/Seasonal-job-matching-platform/Seasonal-job-matching-platform-mobile-app/releases/latest`
2. **Local Comparison**: The app compares the local version code (`versionCode` from `pubspec.yaml` via `package_info_plus`) with the latest release's tag name/version code.
3. **Download URL Extraction**: The app parses the asset list inside the GitHub release payload to find the item ending in `.apk` and extracts its `browser_download_url`.

---

## 2. Update Classification Rules

* **Optional Update**: Triggered when `latestVersion > currentVersion` and the update is not mandatory. The user is prompted with a Modal Bottom Sheet. If dismissed ("Later"), a red badge is shown on the Profile tab icon, and an "Update Available" row appears in [profile_screen.dart](file:///d:/Projects/Seasonal-job-matching-platform-mobile/lib/screens/Profile/profile_screen.dart).
* **Mandatory Update**: Triggered when the release title/body contains `[MANDATORY]` OR the `MAJOR` version number increases (e.g. `2.0.0` vs local `1.0.26`). The user is blocked by a full-screen blocker page and cannot enter the main app layout.

---

## 3. Persistent Profile/Settings Pattern

To avoid nagging the user with constant dialogs:
1. **The Modal Bottom Sheet**: Prompted once on app startup.
2. **Snooze**: If the user clicks "Later", the bottom sheet is snoozed (stored in `SharedPreferences`) and will not show again for **24 hours**.
3. **The Settings Badge**: During the snooze period, a red badge dot is displayed next to the Profile icon in the app navigation bar.
4. **The Update Tile**: Inside the profile screen, a highlighted row displays:
   `Update Available! (vX.Y.Z)`
   Tapping this row opens the update download link immediately.

---

## 4. Pros and Cons

| Pros | Cons |
| :--- | :--- |
| **Zero Infrastructure Cost**: Bypasses the need for databases, APIs, or custom servers by utilizing public GitHub resources. | **Public Repository Exposure**: The APK and repository must be public for the unauthenticated GitHub API to function. |
| **Immediate Delivery**: Updates are published instantly when code is pushed to `main`, bypassing the Google Play Store review delays (typically 1–7 days). | **Manual Installation Approvals**: Android treats direct APK installs as "Unknown Sources". Users must grant installation permission once. |
| **Completely Automated**: GitHub Actions automatically updates build names and build codes from `pubspec.yaml` without manual database entries. | **Rate Limiting**: GitHub API has a rate limit of 60 requests per hour for unauthenticated IP addresses. *(Mitigated by caching the check once per 24 hours).* |
| **Granular Blocker Control**: Easy developer overrides to force mandatory security patches or API deprecations using a commit keyword. | **Wiped caches (if forced downgrades)**: App downgrades require complete uninstallation/reinstallation which wipes local client storage. |
