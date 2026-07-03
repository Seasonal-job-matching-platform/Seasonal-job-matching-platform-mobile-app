# Knowledge Base

> This document is the **single source of truth** for all confirmed
> project facts.
>
> Every fact in this file is considered canonical until explicitly
> updated. If new information conflicts with an existing entry, the
> conflict must be resolved before continuing with the documentation.
>
> Never invent entries. Only add facts that have been confirmed.

------------------------------------------------------------------------

# Project Identity

## Project Name

Seasonal Job Matching Platform Mobile App (`job_seeker`)

## Scope

Document only the mobile application and the author's contributions
unless instructed otherwise.

## Overview

A cross-platform Flutter application for seasonal job seekers that
allows users to: - Register - Search and filter seasonal jobs - Apply
using resumes and cover letters - Track application status - Receive
real-time push notifications

------------------------------------------------------------------------

# Technology Stack

## Frontend

- **Framework:** Flutter SDK (`^3.9.2` environments)
- **Networking:** Dio HTTP Client (`^5.9.0`)
- **Local Storage:** Flutter Secure Storage (`^9.2.2`) for user IDs and tokens
- **Internationalization:** Flutter Localizations (`AppLocalizations` supporting EN/AR)
- **UI & Layout:** Material 3, Google Fonts (Inter, Outfit), Carousel Slider, Svg rendering
- **System Services:** Package Info Plus (`^8.0.0`) for app version checks, URL Launcher (`^6.3.0`) for browser redirects.

## Backend

- **Framework:** Spring Boot RESTful API
- **Deployment Platform:** Heroku (development API hosted at `https://seasonal-job-matching-898a9d15a9e5.herokuapp.com/api/`)

## Database

- **Type:** PostgreSQL Relational Database (Backend-side)
- **Client Caching:** Client keeps in-memory state via Riverpod providers and an optimistic local set for applied jobs (`appliedJobsLocalProvider`). No complex offline client DB is used; token/user parameters are persisted securely.

## Authentication

- **Method:** JWT Token-based authentication
- **Session Management:** Securely cached JWT tokens. Outgoing requests are automatically intercepted by a custom `AuthInterceptor` on Dio to attach headers. Graceful recovery on session expiration (401/403) triggers a single dialog modal and performs a clean state reset across 13 providers.

## Notifications

- **Service:** Firebase Cloud Messaging (FCM) for push alerts
- **In-App Notification List:** Spring Boot Rest Endpoints (`/api/notifications/{userId}`) combined with notification stream listeners that trigger automatic provider invalidation and badge counts.

## State Management

- **Library:** Flutter Riverpod (`^3.0.3`)
- **Generator:** Riverpod Generator (`riverpod_annotation`, `riverpod_lint`, `build_runner`)
- **Pattern:** Declarative caching using `Provider`, `NotifierProvider`, `AsyncNotifierProvider`, and `FutureProvider.family`.

## Architecture

- **Pattern:** Hybrid Clean Architecture (Data, Domain, Presentation) combined with Feature-by-Folder organization.
- **Layers:**
  - **Data:** API service implementations, repositories (`ApplicationsRepository`), and remote DTO models.
  - **Domain:** Business validations and use cases (`ApplyForJobUseCase`).
  - **Presentation (UI):** Reusable widgets, page layout controllers, and Riverpod asynchronous notifiers/controllers.

------------------------------------------------------------------------

# Design Patterns

- **Repository Pattern:** Separates database/network clients from business domain logic (e.g., `ApplicationsRepository`).
- **Use Case Pattern:** Encapsulates business logic transactions into reusable units (e.g., `ApplyForJobUseCase`).
- **Singleton Pattern:** Restricts instantiation of core services to single instances (e.g., `NavigationService`, `NotificationService`).
- **Interceptor Pattern:** Dio interceptors hook into requests/responses to append tokens (`AuthInterceptor`) or handle errors globally.
- **Optimistic Updates:** Tapping favorites or reading notifications instantly updates the UI state before completing network requests, falling back on failure.
- **Aggregator Pattern:** `PersonalInformationAsyncNotifier` fetches and merges data from four separate backend endpoints into a unified model.

------------------------------------------------------------------------

# External Services

- **Heroku:** Hosts the Spring Boot backend REST API.
- **Firebase Core & FCM:** Handles push notification registrations and messaging payloads.
- **Google Fonts:** Delivers professional topography packages (e.g., Inter, Outfit).

------------------------------------------------------------------------

# Major Features

-   User Registration
-   User Authentication
-   Job Search
-   Job Filtering
-   Job Application
-   Resume Upload
-   Cover Letter Submission
-   Application Tracking
-   Push Notifications
-   User-Selected Currency Support
-   GitHub Releases OTA Update System
-   Report an Issue / Feedback Form

------------------------------------------------------------------------

# Project Structure

## Main Modules

-   Authentication
-   Home
-   Job Search
-   Job Details
-   Applications
-   Profile
-   Notifications

------------------------------------------------------------------------

# API

## API Style

- RESTful HTTP API with JSON communication payloads.

## Authentication Method

- Bearer JWT token attached to the `Authorization` header by `AuthInterceptor`.

------------------------------------------------------------------------

# Database

## Database Type

- PostgreSQL (Backend-managed)

## Main Collections / Tables

- Users
- Jobs
- Applications
- Resumes
- Favorites
- Notifications

------------------------------------------------------------------------

# Navigation

- Custom `NavigationService` utilizing a global `rootNavigatorKey` for context-free page routing (e.g., routing to Login from network interceptor errors). Uses standard Navigator transitions (`PageRouteBuilder` and `FadeTransition`) rather than Go_Router.

------------------------------------------------------------------------

# Folder Structure

- `lib/constants`: Configuration boundaries and styling globals.
- `lib/core`: Routing (NavigationService), client setup (Dio Provider), auth interceptors, and logger.
- `lib/data`: Repositories (`ApplicationsRepository`).
- `lib/domain`: Use cases (`ApplyForJobUseCase`).
- `lib/l10n`: Localization files (`app_en.arb`, `app_ar.arb`).
- `lib/models`: Data entities and DTO definitions.
- `lib/providers`: State providers, controllers, and cached notifiers.
- `lib/screens`: Page templates (Auth, Home, Jobs, Applications, Profile).
- `lib/services`: Service endpoints and raw Dio wrappers.
- `lib/theme`: System decorations and transition values (`AppTheme`).
- `lib/utils`: Styling and translation helpers.
- `lib/widgets`: Reusable UI elements.

------------------------------------------------------------------------

# Packages

| Package | Purpose | Status |
| :--- | :--- | :--- |
| `flutter_riverpod` | Reactive state management & DI | Active |
| `dio` | HTTP networking client | Active |
| `flutter_secure_storage` | Session parameters & credentials keychain caching | Active |
| `firebase_core` / `messaging` | Device FCM push synchronization | Active |
| `flutter_local_notifications` | Foreground notification overlays | Active |
| `freezed` / `json_serializable` | Code generation for immutable models | Active |
| `google_fonts` | Typography system | Active |
| `carousel_slider` | Horizontal UI sliders | Active |
| `package_info_plus` | Accesses native platform version codes | Active |
| `url_launcher` | Resolves and opens HTTP release download URLs | Active |

------------------------------------------------------------------------

# Important Classes

| Class | Responsibility |
| :--- | :--- |
| `AuthNotifier` | Synchronizes login states, registers token data, resets cache on logout |
| `ApplicationsRepository` | Checks and processes user job applications |
| `PersonalInformationAsyncNotifier` | Aggregates data from 4 user endpoints into a single model |
| `NavigationService` | Facilitates context-free navigator routing |
| `NotificationService` | Subscribes to FCM stream hooks and pushes local banners |
| `FavoritesController` | Drives optimistic updates and rolls back favorite states on API errors |
| `ResumeNotifier` | Handles resume editor sections and uploads diff states |
| `JobsFilterNotifier` | Tracks dynamic search query filter state parameters |
| `PaginatedJobs` | Manages paginated scrolling with lazy loading and marks viewed job cards |
| `UpdateNotifier` | Checks GitHub Releases for updates, evaluates SemVer criteria, and caches snooze states |
| `FeedbackNotifier` | Manages form loading, extracts user emails when not anonymous, and triggers issue submissions |

------------------------------------------------------------------------

# Confirmed Design Decisions

- **Token-based persistence:** Using `flutter_secure_storage` for session caching instead of insecure key-value preferences.
- **Multi-user Data Protection:** Resetting/invalidating 13 separate Riverpod data providers immediately on logout to eliminate cached data leakage when logging into another account.
- **Hybrid Pagination Rule:** Infinite scrolling triggers automatically for the first 200 jobs; afterwards, a manual "Load More" button is rendered. This avoids frame jank and excessive widget memory overhead (1.5 KB text vs. 50x-100x widget render cost).
- **Glassmorphism Theme Elements:** Implemented within Profile card interfaces for premium aesthetics.
- **Optimistic Heart Icon Toggle:** Favorites update instantly in the UI, and roll back only if the backend API call fails.
- **OTA Update Snooze Cache:** Optional updates dismissed via "Later" are cached in secure storage with a 24-hour timestamp to suppress subsequent startup bottom sheet displays.
- **Currency-Driven Job List Refetching:** Selecting a new currency updates the user profile on the backend and triggers dynamic invalidation of `paginatedJobsProvider` and `recommendedJobsProvider` to automatically reload job listings in the new currency.

------------------------------------------------------------------------

# Assumptions

This section should remain empty whenever possible.

Any temporary assumption must: 1. Be clearly marked. 2. Include the
reason it was made. 3. Be removed once confirmed.

------------------------------------------------------------------------

# Open Questions

List unresolved questions that must be answered before documentation
continues.

-   None.

------------------------------------------------------------------------

# Change Log

  Version   Date      Description
  --------- --------- ----------------------------------
  1.0       Initial   Created knowledge base template.
