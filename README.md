# Elevate Academy — Mobile App

A Flutter client for the Elevate Academy platform. Students log in, see their
enrolled courses, attend classes, submit assignments, etc. This README
explains how the app is put together — read this before touching auth or
course code.

---

## Running it locally

1. Start the backend server (separate project, not in this repo) so it's
   listening on **port 4002**. The full API contract is in `SERVER_API.md`.
2. `flutter pub get`
3. `flutter run` and pick a device.

The app figures out how to reach `localhost:4002` on its own
(`lib/apis/base_url.dart`) — but "localhost" doesn't mean the same thing
everywhere:

| Where the app runs | Host it hits | Handled automatically? |
|---|---|---|
| Web (Chrome), macOS/Windows/Linux desktop, iOS Simulator | `localhost:4002` | ✅ |
| Android Emulator | `10.0.2.2:4002` (the emulator's alias for the host machine) | ✅ |
| A physical phone over Wi-Fi | the computer's LAN IP, e.g. `192.168.1.42:4002` | ❌ not wired up yet |

If someone needs to test on a real device, they'll need the server to bind
to `0.0.0.0` (not just `127.0.0.1`) and the app pointed at the host's LAN IP —
ask before adding that, it's not built yet.

---

## State management: Provider

The app uses the [`provider`](https://pub.dev/packages/provider) package.
The pattern to know:

- A **provider** (e.g. `AuthProvider`, `CourseProvider`) is a class that
  `extends ChangeNotifier`. It holds some state (fields) and calls
  `notifyListeners()` whenever that state changes.
- A **widget** reads that state with `context.watch<AuthProvider>()`
  (rebuilds automatically when the provider changes) or
  `context.read<AuthProvider>()` (one-off read, e.g. inside a button's
  `onPressed`, doesn't rebuild).
- Providers are registered once, at the top of the widget tree, in
  `lib/main.dart`'s `MultiProvider`.

Widgets never talk to the network directly. They watch a provider; the
provider talks to an "API" class; the API class does the actual HTTP call.
Every feature in this app follows that same four-layer shape:

```
Screen/Widget  →  Provider (ChangeNotifier)  →  Api class  →  ApiClient (generic HTTP)
```

---

## Auth: login, persistence, roles, logout

| Layer | File |
|---|---|
| Base URL | `lib/apis/base_url.dart` |
| Generic HTTP helper | `lib/apis/api_client.dart` |
| Endpoint URLs | `lib/apis/endpoints/auth_endpoints.dart` |
| API call | `lib/apis/auth_api.dart` |
| Model | `lib/models/app_user.dart` |
| Session persistence | `lib/services/session_storage.dart` |
| State | `lib/providers/auth_provider.dart` |
| Entry point / routing | `lib/main.dart` (`AuthGate`) |
| Login UI | `lib/screens/auth_screens/login_screen.dart` |

**How it flows:**

1. User taps Login → `login_screen.dart` calls
   `context.read<AuthProvider>().login(username, password)`.
2. `AuthProvider.login()` calls `AuthApi.login()`, which does the actual
   `POST /api/auth/login` (via `ApiClient`) and returns a token + user.
3. On success, `AuthProvider` saves the token/user to `shared_preferences`
   via `SessionStorage`, sets `status = AuthStatus.authenticated`, and
   `notifyListeners()`.
4. `login_screen.dart` then reads `auth.user!.isStudent` and navigates to
   `StudentShell` (students) or `AdminScreen` (everyone else — admin/
   instructor UI is still a placeholder).
5. **Staying logged in:** on every app launch, `main.dart`'s `AuthGate`
   calls `AuthProvider.tryAutoLogin()` first, which reads any saved session
   from `SessionStorage`. If one exists, the user skips straight past
   `WelcomeScreen`/`LoginScreen` into the right role's screen — no need to
   log in again.
6. **Logout:** both `StudentsHome` (via the profile card) and `AdminScreen`
   call `AuthProvider.logout()`, which clears `SessionStorage` and resets
   state, then navigate back to `WelcomeScreen`.

`AppUser.isStudent` (`lib/models/app_user.dart`) is the one role check the
app currently makes — `roles.contains('STUDENT')`. Everything that isn't a
student currently lands on the placeholder `AdminScreen`. There's no
`'ADMIN'` role check — it's "not a student" that routes there, not an
explicit role match.

`AppUser` also parses a `permissions` field (`List<String>`, from
`json['permissions']`) and serializes it back in `toJson()`, but nothing in
the app reads it — no screen or provider checks `permissions` for anything.
It's a modeled-but-unused field, likely a placeholder for finer-grained
permission checks later.

---

## Courses: how a student's enrolled courses get picked

Same four-layer shape as auth, applied to courses:

| Layer | File | Job |
|---|---|---|
| UI (widget) | `lib/componets/tiles/course_card.dart` | Renders one course card (title, progress bar, icon/color) |
| UI (screen) | `lib/screens/app_screens/Students_screen/students_home.dart` | "My Courses" section: count header, swipeable `_CourseCarousel`, and the client-side `courseSlug → icon/color` lookup |
| State | `lib/providers/course_provider.dart` | Holds `enrollments` / `isLoading` / `error`, exposes `fetchEnrollments()` |
| API call | `lib/apis/course_api.dart` | The actual `GET /api/courses/enrollment?contactId=...` request |
| Endpoint URL | `lib/apis/endpoints/course_endpoints.dart` | Just the URL string |
| Model | `lib/Models/enrollment.dart` | Parses the server's JSON into a typed `Enrollment` |

**Important:** `CourseProvider` never decides *when* to fetch — it's told
to. That happens in exactly two places: `login_screen.dart` (right after a
student logs in) and `main.dart`'s `AuthGate` (right after restoring a saved
session on app restart). Both pass `user.contactId` (**not** `user.id` — the
server treats the login account and the student/contact record as separate
things, linked by `contactId`).

`students_home.dart` just does `context.watch<CourseProvider>()` and renders
whatever's there: a spinner while `isLoading`, an error message, "No courses
yet" if the list is empty, one full-width card if there's exactly one
course, or a swipeable one-at-a-time carousel (with dot indicators) if
there's more than one.

**A gap worth knowing about:** `SERVER_API.md` documents the enrollment
response as including `courseSlug`, but the real running server doesn't
send it — only `course.name`. `Enrollment.fromJson` derives a slug from the
course name as a fallback so the icon/color lookup in `students_home.dart`
still works. If the server ever starts sending `courseSlug` for real,
nothing needs to change — it'll just be used directly.

---

## Known inconsistencies / things to clean up eventually
- Physical-device testing (real phone over Wi-Fi) isn't supported by
  `base_url.dart` yet — only emulators/simulators/desktop/web.
- `AdminScreen` and `HomeScreen` are placeholders — role-based routing
  sends non-students there, but there's no real admin UI built yet.
