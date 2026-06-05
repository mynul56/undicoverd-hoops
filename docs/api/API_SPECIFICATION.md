# UNDISCOVERED HOOPS: API SPECIFICATION + REAL-TIME CONTRACTS

**Version:** 1.0.0 (Production Lock)
**Base URL:** `https://api.undiscoveredhoops.com/v1`

This document is the absolute source of truth for all API communication across the Undiscovered Hoops ecosystem. No frontend or backend deviation is permitted.

---

## 1. GLOBAL STANDARDS

### Authentication Model
All requests (except `/auth/*` open routes) must include a valid JWT in the headers:
`Authorization: Bearer <JWT>`

- **JWT Expiration:** 1 Hour
- **Refresh Mechanism:** Must use `/auth/refresh` before expiration.
- **Embedded Claims:** Token contains `userId`, `role` (player, coach, admin).

### Standard Response Envelope
All REST API responses (success or failure) must adhere to this standard envelope:
```json
{
  "success": true,
  "data": {},
  "error": null,
  "meta": {
    "timestamp": "2026-06-05T12:00:00Z"
  }
}
```

### Pagination Standard
Endpoints returning lists use cursor-based pagination.
**Request Query:** `?cursor=last_id_or_timestamp&limit=20`
**Response Meta:**
```json
"meta": {
  "nextCursor": "abc123xyz",
  "hasMore": true
}
```

---

## 2. ERROR TAXONOMY (CRITICAL)
Errors are returned with `success: false` and a populated `error` object.
```json
"error": {
  "code": "AUTH_001",
  "message": "Invalid credentials"
}
```

**Standardized Codes:**
- `AUTH_001`: Invalid credentials
- `AUTH_002`: Token expired
- `AUTH_003`: Unauthorized access / Insufficient permissions
- `USER_404`: User not found
- `PAY_001`: Payment failed
- `REEL_001`: Upload failed
- `CHAT_001`: Message delivery failed
- `CALL_001`: Call connection failed
- `VAL_001`: Validation Error (check payload)
- `SYS_500`: Internal Server Error

---

## 3. RATE LIMITING RULES
Enforced per IP / User ID at the API Gateway level.
- **Login:** 5 requests / minute
- **Reel Upload:** 10 requests / hour
- **Chat Send:** 60 requests / minute
- **Swipe:** 100 requests / minute

---

## 4. PERMISSION RULES (RBAC)
Enforced via Guard/Middleware at the backend.
- **Player:** Read-only global search, limited chat (matches/mutuals), full profile edit.
- **Coach:** Full search (filters by stats/metrics), direct contact initiation allowed.
- **Admin:** Full system access, CMS/Events management.

---

## 5. REST API CONTRACTS

### 5.1 Auth Service (`/auth`)
#### Login
`POST /auth/login`
- **Request:** `{ "email": "str", "password": "str" }`
- **Response:**
  ```json
  "data": {
    "token": "jwt_token",
    "refreshToken": "refresh_token",
    "user": {
      "id": "uuid",
      "email": "user@example.com",
      "role": "player"
    }
  }
  ```

#### Register
`POST /auth/register`
- **Request:** `{ "email": "str", "password": "str", "role": "player|coach" }`
- **Response:** Same as login.

---

### 5.2 User Service (`/users`)
#### Get Profile
`GET /users/{id}`
- **Response:** 
  ```json
  "data": {
    "id": "uuid",
    "firstName": "John",
    "lastName": "Doe",
    "position": "PG",
    "school": "Example High",
    "height": "6'2\"",
    "stats": {}
  }
  ```

#### Update Profile
`PUT /users/{id}`
- **Request:** (Partial profile object)
- **Response:** Updated profile object.

---

### 5.3 Reels Service (`/reels`)
#### Upload Reel
`POST /reels/upload`
- **Rules:** Requires multipart upload. Presigned S3 URLs strongly recommended.
- **Request:** FormData with `video` file and `metadata` JSON string.
- **Response:** `{ "id": "uuid", "url": "cdn_url", "status": "processing" }`

#### Get Feed
`GET /reels/feed?cursor={cursor}&limit=20`
- **Response:** Array of Reel objects.

#### Like Reel
`POST /reels/{id}/like`
- **Response:** `{ "liked": true, "totalLikes": 150 }`

---

### 5.4 Chat Service (`/chat`)
#### Get Conversations
`GET /chat/conversations?cursor={cursor}`
- **Response:** Array of conversation summary objects.

#### Send Message (Fallback to REST)
`POST /chat/send`
- **Request:** `{ "conversationId": "uuid", "message": "str" }`
- **Response:** `{ "messageId": "uuid", "timestamp": "ISO8601" }`

---

### 5.5 Matching Service (`/matches`)
#### Swipe Action
`POST /matches/swipe`
- **Request:** `{ "targetUserId": "uuid", "action": "like" | "dislike" | "favorite" }`
- **Response:** `{ "isMatch": bool, "matchId": "uuid|null" }`

#### Get Matches
`GET /matches`
- **Response:** Array of matched user profiles.

---

### 5.6 Subscription Service (`/billing`)
#### Create Checkout Session
`POST /billing/checkout`
- **Request:** `{ "tierId": "str" }`
- **Response:** `{ "checkoutUrl": "str" }`

#### Webhook (Stripe)
`POST /billing/webhook`
- **Response:** `{ "received": true }` (No standard envelope required for Stripe compliance).

---

### 5.7 Events Service (`/events`)
#### Create Event
`POST /events`
- **Request:** `{ "title": "str", "date": "ISO8601", "location": "str" }`
- **Response:** Event object.

#### RSVP Event
`POST /events/{id}/rsvp`
- **Request:** `{ "status": "attending" | "declined" }`
- **Response:** Updated RSVP status.

---

### 5.8 Notification Service (`/notifications`)
#### Get Notifications
`GET /notifications?cursor={cursor}`
- **Response:** Array of notification objects.

#### Mark Read
`POST /notifications/{id}/read`
- **Response:** `{ "read": true }`

---

## 6. WEBSOCKET SYSTEM (REAL-TIME LAYER)

**Endpoint:** `wss://api.undiscoveredhoops.com/realtime`
**Auth:** Requires valid JWT in connection handshake (`auth: { token: 'JWT' }`).

### 6.1 Message Events
**Client Emit (Send Message):**
```json
{
  "event": "message.send",
  "data": {
    "conversationId": "uuid",
    "senderId": "uuid",
    "message": "Hello!"
  }
}
```

**Server Broadcast (Receive Message):**
```json
{
  "event": "message.receive",
  "data": {
    "messageId": "uuid",
    "conversationId": "uuid",
    "senderId": "uuid",
    "message": "Hello!",
    "timestamp": "ISO8601"
  }
}
```

### 6.2 Call Events (WebRTC Signaling)
**Client Emit (Offer):**
```json
{
  "event": "call.offer",
  "data": {
    "targetUserId": "uuid",
    "callId": "uuid",
    "sdp": "session_description_string"
  }
}
```

**Server Route -> Recipient (Incoming Offer):**
```json
{
  "event": "call.incoming",
  "data": {
    "callerId": "uuid",
    "callId": "uuid",
    "sdp": "session_description_string"
  }
}
```

**Recipient Emit (Answer):**
```json
{
  "event": "call.answer",
  "data": {
    "callerId": "uuid",
    "callId": "uuid",
    "sdp": "session_description_string"
  }
}
```

**ICE Candidate Exchange (Bidirectional):**
```json
{
  "event": "call.ice",
  "data": {
    "targetUserId": "uuid",
    "callId": "uuid",
    "candidate": "ice_candidate_string"
  }
}
```

### 6.3 Presence Events
**Server Broadcast:**
```json
{
  "event": "user.online",
  "data": {
    "userId": "uuid"
  }
}
```
*(Offline events follow the same structure using `user.offline`)*
