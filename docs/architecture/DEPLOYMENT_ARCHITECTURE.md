# UNDISCOVERED HOOPS: PRODUCTION DEPLOYMENT ARCHITECTURE
**Version:** 1.0.0 (Global Scale + Zero Downtime Lock)

This document serves as the absolute blueprint for the cloud infrastructure, horizontal scaling, and disaster recovery design for the Undiscovered Hoops platform. It guarantees real-time stability, media streaming efficiency, and zero-downtime deployments.

---

## 1. GLOBAL SYSTEM ARCHITECTURE (AWS)

```mermaid
graph TD
    Client[Flutter App Clients] --> R53[Route 53 DNS]
    
    R53 --> CF[CloudFront CDN]
    CF --> S3[S3 Bucket - Reels & Media]
    
    R53 --> ALB[Application Load Balancer]
    ALB --> AGW[API Gateway]
    
    subgraph Compute (EKS/ECS)
        AGW --> Auth[Auth Service]
        AGW --> Reels[Reels Service]
        AGW --> Match[Match Service]
        AGW --> Billing[Billing Service]
        
        AGW --> WS[WebSocket Cluster]
        AGW --> WebRTC[WebRTC Signaling]
    end
    
    subgraph Real-Time & Event Bus
        WS <--> Redis[Redis Pub/Sub]
        WebRTC <--> Redis
        Auth --> Kafka[Kafka / SQS Event Bus]
        Billing --> Kafka
    end

    subgraph Data Tier (Multi-AZ)
        Auth --> RDS[(Amazon RDS - Primary)]
        Billing --> RDS
        RDS -.-> RDS_Rep[(RDS - Read Replica)]
        
        Reels --> DocDB[(Amazon DocumentDB)]
        Match --> DocDB
    end
```

---

## 2. BACKEND SCALING STRATEGY

All backend components are designed as stateless microservices containerized via Docker and orchestrated via Kubernetes (EKS) or Amazon ECS.

### Auto-Scaling Rules
- **Triggers:** Scale-out triggered when average CPU utilization > 70% or API latency > 200ms.
- **WebSocket Scaling:** `chat-service` and `call-service` pods are scaled based on active concurrent connections (e.g., target 5,000 connections per pod). 
- **Sticky Sessions:** Enabled at the ALB for WebRTC signaling to ensure ICE candidate exchange hits the correct node before P2P establishment.
- **Event-Driven Workloads:** Heavy tasks (video transcoding) use async workers consuming from SQS.

---

## 3. DATABASE ARCHITECTURE (PRODUCTION GRADE)

### Relational Data (PostgreSQL via RDS)
- **Primary Node:** Handles all strict ACID transactions (Auth, Subscriptions).
- **Read Replicas:** Deployed across multiple Availability Zones (AZs) for read-heavy operations (e.g., fetching profiles).
- **Failover Strategy:** Automatic DNS promotion of standby instance in the event of primary AZ failure.

### NoSQL & Cache
- **DocumentDB (MongoDB compatible):** Horizontally sharded for Reels metadata and Event logging.
- **Redis Cluster (ElastiCache):** Serves three purposes:
  1. API Response Caching.
  2. Pub/Sub backplane for scaling WebSocket nodes.
  3. Ephemeral state storage for WebRTC signaling.

---

## 4. CDN STRATEGY (REELS SYSTEM CRITICAL)

The Reels feed requires maximum efficiency to support 50k views/min and sub-second playback.
- **Upload Flow:** Client → API Gateway (Presigned URL) → S3 Bucket directly.
- **Transcoding:** S3 `ObjectCreated` event triggers AWS Elemental MediaConvert to generate HLS (HTTP Live Streaming) playlists and chunked `.ts` segments.
- **Delivery Flow:** S3 → CloudFront Edge Caches → User Playback.
- **Security:** Video playback is secured via CloudFront signed URLs/cookies validating JWT roles.

---

## 5. ZERO DOWNTIME CI/CD DEPLOYMENT

### Blue-Green Deployment Strategy
Traffic is dynamically shifted using AWS CodeDeploy and Route53 weighted routing.
1. **Deploy:** New code (Green) is deployed to idle infrastructure alongside the live environment (Blue).
2. **Validate:** Automated End-to-End tests execute against the Green environment.
3. **Cutover:** If tests pass, load balancer shifts 10% of traffic to Green. If error rates remain flat, traffic shifts to 100%.
4. **Rollback:** Instantaneous rollback triggered if Datadog detects elevated 5xx errors.

### Database Migrations
Migrations run asynchronously *before* the Blue-Green cutover and **must be backward compatible** (e.g., adding columns, never renaming/deleting without a deprecation cycle).

---

## 6. FLUTTER APP DEPLOYMENT

### Release Channels
- **Dev / Alpha:** Firebase App Distribution for internal engineering QA.
- **Beta:** Apple TestFlight and Google Play Console Internal Track.
- **Production:** Phased rollouts (10% -> 50% -> 100%) via App Store/Play Store.
### Crash Management
- Firebase Crashlytics tied directly to PagerDuty for real-time alerting on fatal crash spikes (>1% sessions).

---

## 7. OBSERVABILITY & MONITORING STACK

- **Metrics (Prometheus & Datadog):** Tracking API latency, 4xx/5xx rates, WS connection counts, and WebRTC setup times.
- **Logs (ELK Stack / Datadog):** Centralized structured JSON logging across all microservices. Trace IDs injected via API Gateway follow requests through Kafka and DB layers.
- **Errors (Sentry):** Aggregates unhandled exceptions on the Flutter frontend and Node.js backend.

---

## 8. DISASTER RECOVERY (DR) PLAN

| Failure Scenario | Mitigation Strategy | RTO (Recovery Time) |
| :--- | :--- | :--- |
| **Primary Database Failure** | Auto-promotion of Multi-AZ standby replica. | < 2 Minutes |
| **AWS Region Outage** | Route53 failover routing to secondary region (Warm Standby). | < 15 Minutes |
| **Media S3 Deletion/Loss** | Cross-Region Replication (CRR) and strict object versioning. | 0 Minutes |
| **Stripe Webhook Failure** | SQS Dead Letter Queue (DLQ) captures failed webhooks for automatic retry. | Near Real-time |

---

## 9. PERFORMANCE & SCALING TARGETS

The architecture is provisioned to comfortably handle 100k -> 1M DAU with the following SLIs:
- **API Latency:** < 300ms (95th percentile)
- **Reels Feed Load:** < 1s
- **Chat Message Latency:** < 200ms
- **Call Setup (Signaling):** < 2s
- **Concurrent Scaling Limits:**
  - 10,000 concurrent WebSockets
  - 1,000 concurrent active WebRTC sessions
  - 50,000 reel views per minute
