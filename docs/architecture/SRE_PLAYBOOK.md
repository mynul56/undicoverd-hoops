# UNDISCOVERED HOOPS: SRE & OPERATIONS PLAYBOOK
**Version:** 1.0.0 (Production Control Lock)

This operations manual governs the live production environment of Undiscovered Hoops. The primary goals are stability under real traffic, rapid incident recovery (MTTR), and strict enforcement of Service Level Objectives (SLOs).

---

## 1. INCIDENT SEVERITY CLASSIFICATION

| Severity | Definition | Resolution SLA |
| :--- | :--- | :--- |
| **SEV-1** | System completely down / Payments broken / WebRTC calls broken. | Immediate (MTTR < 15m) |
| **SEV-2** | Major feature failure (Reels feed degraded, Chat offline). | < 2 Hours |
| **SEV-3** | Partial feature issues (Specific device bugs, slow queries). | < 24 Hours |
| **SEV-4** | Minor UI bugs / Non-critical visual issues. | Next Sprint |

---

## 2. SEV-1 INCIDENT RESPONSE FLOW

**Target Time-to-Acknowledge:** 5 minutes.
**Target Time-to-Mitigate:** 15 minutes.

1. **Detect & Alert:** PagerDuty calls the Primary On-Call Engineer.
2. **Acknowledge:** Engineer acknowledges the page within 5 minutes.
3. **Communicate:** Engineer joins the `#incident-sev1` Slack channel and opens a war room (Zoom/Meet).
4. **Mitigate (Rollback First):** If a deployment occurred in the last hour, **ROLLBACK IMMEDIATELY**. Do not attempt to debug live if a rollback solves the outage. Rollbacks require zero approval during SEV-1.
5. **Fix:** Once stabilized (mitigated), investigate root cause.
6. **Postmortem:** Scheduled within 48 hours.

---

## 3. ON-CALL SYSTEM

- **Rotation:** 24/7 weekly rotation.
- **Primary:** Responds to all alerts. 5-minute SLA.
- **Secondary:** Escalation point if Primary misses the 5-minute SLA.
- **Tools:** Datadog -> PagerDuty -> Slack integrations.

---

## 4. MONITORING RULES & SLOs

### System Metrics (Service Level Objectives)
| Service | SLO | Alert Trigger |
| :--- | :--- | :--- |
| **API Gateway Uptime** | 99.9% | 5xx errors > 1% over 5 mins |
| **Chat Delivery** | 99.95% | WebSocket disconnect spike > 5% |
| **Call Success Rate** | 99.9% | Signaling timeouts > 1% |
| **Payment Success** | 99.99% | Stripe webhook failures > 0 |
| **Reel Upload Success** | 99.9% | S3/CDN upload timeouts > 1% |
| **API Latency** | P95 < 300ms | Latency spike > 500ms sustained |

---

## 5. LOGGING & OBSERVABILITY

- **Distributed Tracing:** Every API request generates a unique `x-trace-id`. This ID is passed to all microservices, Kafka events, and logs.
- **Centralized Tooling:** 
  - ELK Stack / Datadog for log aggregation.
  - Sentry for exception tracking (Flutter + Node.js).
  - Grafana for visual dashboards of Redis, Postgres, and ECS health.
- **Mandatory Logs:** Authentication failures, Payment lifecycle events, Video upload statuses, WebRTC ICE connection states.

---

## 6. ROLLBACK STRATEGY (CRITICAL)

**Rule: Every deployment must be reversible in < 5 minutes.**

1. **Blue-Green Cutback:** If the new "Green" deployment fails within the observation window, Route53 traffic is instantly routed 100% back to "Blue".
2. **Feature Flags:** If a specific feature breaks, toggle it off instantly via LaunchDarkly (or equivalent) without needing a code deploy.
3. **Database Safety:** Migrations are strictly backward compatible. Dropping columns or renaming tables without a multi-release phase is strictly prohibited to ensure code rollbacks don't crash against altered schemas.

---

## 7. SCALING OPERATIONS

### Auto-Scaling Rules
- **Compute (ECS/EKS):** Trigger scale-out when CPU > 70% for 3 minutes.
- **WebSocket Cluster:** Scale based on concurrent active connections (e.g., add pod per 5k active sockets).

### Manual Emergency Scaling
If auto-scaling fails or traffic spikes unnaturally (e.g., viral event):
- Immediately double backend container instances manually.
- Scale up Redis node sizes for signaling/pub-sub headroom.
- Increase database Read Replica count to offload read pressure.

---

## 8. POSTMORTEM PROCESS (MANDATORY)

Required for all **SEV-1** and **SEV-2** incidents within 48 hours of resolution. The goal is *blameless* root cause analysis.

**Postmortem Template:**
```text
Incident Name: [Short description]
Severity: [SEV-1/SEV-2]
Start Time: [ISO8601]
End Time: [ISO8601]
Time to Detect (MTTD): [Minutes]
Time to Resolve (MTTR): [Minutes]

Root Cause: [The "5 Whys" analysis of the underlying failure]
Impact Scope: [User impact, revenue impact, data impact]
Detection Method: [How did we find out? Automated alert or user report?]
Resolution: [What steps stabilized the system?]
Preventive Actions: [Jira Tickets created to ensure this exact failure NEVER happens again]
```

---

## 9. RELEASE MANAGEMENT

- **Hotfix:** Emergency bypass of normal sprint schedule. Only for SEV-1/SEV-2 mitigation.
- **Patch:** Non-critical bug fixes batched weekly.
- **Release:** Major feature deployments following full QA gating and Blue-Green staging.

**Release Safety Rule:** No production deployment without Staging Sign-off. No DB migration without a rollback plan. No risky feature without a kill switch.

---

## 10. COST & SECURITY MONITORING

### Cost Controls
Alerts configured in AWS Cost Explorer if weekly spend anomalies occur for:
- CDN Egress (CloudFront video delivery).
- WebRTC TURN server relay bandwidth.
- Database auto-scaling events.

### Security Defenses
- WAF (Web Application Firewall) configured to auto-block IPs triggering "Failed Login Spikes" (brute force).
- Rate limits aggressively enforced on `/auth`, `/chat`, and `/billing` endpoints.
- All at-rest data encrypted (KMS).
