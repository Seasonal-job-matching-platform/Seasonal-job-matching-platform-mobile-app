# Walkthrough: LinkedIn Profile Seeding & Verification Workflow

This document details the successful execution of the automated workflow script `seed_linkedin_profiles.py` to register the parsed profiles, set up their resumes, configure their Fields of Interest (FOI), and verify the data on the Heroku API.

## Seeding Sequence Walkthrough

The script executed the following operations for each profile:
1. **Authentication Flow (Idempotent)**:
   - Attempted `POST /api/users` with profile credentials.
   - If the account was already registered (returned `Status 400`), it automatically fell back to log in using `POST /api/users/login`.
   - Retrieved the user's authentic `token` and database `user_id`.
2. **Resume Creation**:
   - Made a `POST /api/resumes/{user_id}` request with the auth token.
3. **Resume Details Patch**:
   - Made a `PATCH /api/resumes/{user_id}` request to populate lists of:
     - `education`
     - `experience`
     - `certificates`
     - `skills`
     - `languages`
4. **Fields of Interest (FOI) Configuration**:
   - Made a `PATCH /api/users/{user_id}` request (mapping to `editUserById`) with the list of `fieldsOfInterestToAdd`.
5. **FOI Verification**:
   - Sent a `GET /api/users/FOI/{user_id}` request to confirm the Fields of Interest were persisted correctly.

---

## Seeded User Accounts Log

Below is the list of active user accounts registered and verified on the server (using default password `Password123!`):

| Name | Email | Inferred Fields of Interest | DB User ID | Status |
|---|---|---|---|---|
| **Abdelrahman Mashaal** | `abdelrahmanmashaal@gmail.com` | Software Development, Data Science, Project Management | **405** | Success |
| **Abdelrahman Mohamed** | `abdelrahman.moh984@gmail.com` | Software Development, UX/UI Design, Business Analysis | **406** | Success |
| **Ahmed Bahig** | `ahmedbahig2003@gmail.com` | Software Development, Project Management | **407** | Success |
| **Ahmed Hossam** | `ahmed.hossamnabih@gmail.com` | Project Management, Software Development | **408** | Success |
| **Ahmed Ismail** | `es-ahmed.ismael2026@alexu.edu.eg` | Software Development, UX/UI Design | **409** | Success |
| **Ahmed Nasser** | `am26339@gmail.com` | Software Development, Data Science | **410** | Success |
| **Ahmed Zaki** | `ahmed525zaki@gmail.com` | Data Science, Business Analysis | **411** | Success |
| **Baher Adawy** | `baheradawy_new@gmail.com` | Software Development, UX/UI Design | **415** | Success |
| **Mariem Mohamed** | `mariemmohamed1421@gmail.com` | Software Development, UX/UI Design | **412** | Success |
| **Moataz Fahmy** | `motaz.fahmy.hassan@gmail.com` | Software Development | **413** | Success |
| **Samia Hafez** | `samia.hafez@example.com` | Software Development, Project Management | **414** | Success |

---

## Verification Summary

All 11 profiles were successfully verified.
- **GET `/api/users/FOI/{userId}`**: Returned the correct lists of interests.
- **PATCH `/api/resumes/{userId}`**: Confirmed resume contents (Experience, Education, etc.) were saved.
