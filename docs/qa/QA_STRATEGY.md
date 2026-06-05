# UNDISCOVERED HOOPS: QA AUTOMATION + RELEASE GATE SYSTEM

**Version:** 1.0.0 (Production Safety Lock)

This document dictates the automation, performance validation, and release approval procedures for Undiscovered Hoops. No feature, module, or hotfix is considered “done” or eligible for production unless it passes these stringent QA gates.

---

## 1. QA ARCHITECTURE & TEST TIERS

The QA strategy enforces a defense-in-depth approach utilizing five distinct test tiers:

- **T1 → Unit Tests (Logic Layer):** Validates deterministic inputs/outputs for algorithms, isolated BLoC state transitions, and pure utility functions.
- **T2 → Widget Tests (Flutter UI):** Asserts rendering correctness, structural integrity, and user interaction logic without network dependencies.
- **T3 → Integration Tests (API + DB):** Ensures backend microservices interact correctly with their databases, the API gateway, and each other.
- **T4 → End-to-End Tests (Full User Flows):** Executes fully automated user journeys (e.g., Appium/Flutter integration tests) across the live stack or high-fidelity staging environment.
- **T5 → Load + Stress Tests (Scalability):** Pushes the system to extreme capacity using K6/Artillery to validate latency and infrastructure resilience.

---

## 2. CRITICAL USER FLOWS (BLOCKING TESTS)

If ANY of the automated tests targeting these flows fail, the CI/CD pipeline **MUST ABORT**, and the release is **BLOCKED**.

### Flow 1: Authentication
- Login success (valid credentials)
- Login failure handling (invalid credentials)
- Token refresh sequence
- Role assignment correctness

### Flow 2: Profile Management
- Profile creation & updates
- Profile visibility enforcement rules
- Claim profile admin workflow

### Flow 3: Reels Flow (Media Critical)
- Video upload success (Multipart S3 pipeline)
- Upload retry after network interruption
- Background upload stability
- Feed payload loading & Auto-play initialization

### Flow 4: Chat Flow (Real-Time Text)
- Immediate message send/receive via WebSocket
- Offline message queuing and sync on reconnect
- Read receipt broadcasts
- Media attachment delivery

### Flow 5: WebRTC Call Flow (Highest Risk)
- Call initiation & signaling (Offer/Answer generation)
- Call accept/reject state handling
- ICE candidate exchange and P2P connection establishment
- Call drop and auto-recovery
- OS-level background call survival

### Flow 6: Payment Flow (Revenue Critical)
- Stripe checkout session generation success
- Subscription activation via Stripe webhook
- Subscription cancellation lifecycle
- Enforced trial tier degradation

### Flow 7: Matching Flow
- Swipe left/right transactional logic
- Mutual match creation triggers
- Match persistence in MongoDB
- Notification delivery upon match

---

## 3. AUTOMATION IMPLEMENTATION RULES

### 3.1 Flutter BLoC Testing
- **Mandate:** Every BLoC feature must have 100% test coverage for state transitions. No untested paths allowed.
- **Example Pattern:**
  ```dart
  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when login is successful',
    build: () {
      when(mockRepo.login(any, any)).thenAnswer((_) async => Right(mockUser));
      return AuthBloc(mockRepo);
    },
    act: (bloc) => bloc.add(const LoginRequested(email: 'e', password: 'p')),
    expect: () => [AuthLoading(), AuthSuccess(mockUser)],
  );
  ```
- **Error States:** Explicitly test `NetworkFailure` and `ServerFailure` branches for all BLoC events.

### 3.2 Backend API Testing
- **Mandate:** Every REST endpoint in the microservices must be tested against:
  1. Success scenario (e.g., 200/201 HTTP status)
  2. Failure scenario (business logic constraints)
  3. Invalid input schema (400 Bad Request)
  4. Authentication failure (401 Unauthorized / 403 Forbidden)

### 3.3 WebSocket & WebRTC Testing
- **Latency Assertions:** Automated tests must verify message delivery payload under simulated latency conditions.
- **Reconnect Logic:** Must forcibly disconnect socket connections during tests and assert successful queue syncing upon reconnect.
- **Presence Validation:** Assert that the `user.online` / `user.offline` events fire accurately when sockets connect/drop.

---

## 4. LOAD TESTING (SCALABILITY GATES)

Prior to any major release, K6 load test scripts must be executed against the staging infrastructure to validate the following thresholds:

| System Subsystem | Load Scenario | Performance Threshold |
| :--- | :--- | :--- |
| **Reels Feed** | 10k concurrent users | P95 Response < 1s |
| **Chat Sockets** | 5k concurrent active WS connections | Delivery Latency < 200ms |
| **Call Signaling**| 1k concurrent call setups | Signaling delay < 500ms |
| **Notifications** | 50k push events/minute | Delivery queue processing < 5s |
| **REST APIs** | Global synthetic traffic | P95 Response < 300ms |

---

## 5. EDGE CASE TESTING REQUIREMENTS

Test automation engineers must continuously implement integration tests covering the following edge scenarios:
- Severely throttled network connections (3G simulation).
- Complete loss of network during uploads/calls.
- Application backgrounding/killing during critical state transitions.
- Idempotent request handling (duplicate swipe/payment submissions).
- Processing of duplicate or out-of-order Stripe webhooks.

---

## 6. RELEASE GATE SYSTEM (NO EXCEPTIONS)

The GitHub Actions CI/CD deployment to the `production` environment is hardware-locked to the QA pipeline output.

**Release is automatically BLOCKED unless:**
- ✅ 100% of Critical Flow End-to-End tests pass.
- ✅ 0 `P0` (Critical/Blocker) bugs exist in the current sprint tracker.
- ✅ 0 Payment or Subscription failure test outcomes.
- ✅ 0 WebRTC connection failures in the automated matrix.
- ✅ 95%+ Backend API unit/integration coverage is reported.

*Note: Flaky tests may be retried automatically up to 2 times by the CI runner. If a test fails deterministically on all retries, the build fails. Inconsistent tests must be flagged, quarantined (preventing them from blocking releases), and assigned to engineering for immediate stabilization.*

---

## 7. OBSERVABILITY REQUIREMENTS
Upon release, the following telemetry pipelines must be operational to rapidly detect failures that bypass automated QA:
- **Frontend Crash Reporting:** Firebase Crashlytics + Sentry (Flutter).
- **Backend Log Aggregation:** Datadog or AWS CloudWatch capturing all API Gateway requests.
- **Socket Monitoring:** Redis Pub/Sub backpressure and connection drop rates mapped in Grafana.
- **Revenue Protection:** Alerts triggered to Slack for any `PAY_001` or failed Stripe webhook events.
