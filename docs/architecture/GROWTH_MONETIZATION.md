# UNDISCOVERED HOOPS: GROWTH & MONETIZATION STRATEGY
**Version:** 1.0.0 (Product Revenue Engine Lock)

This document outlines the core business logic, viral loops, and monetization architecture for Undiscovered Hoops. The platform operates as a **recruitment-driven network marketplace with media engagement + subscription monetization layers**.

---

## 1. CORE PRODUCT & VIRAL LOOPS

The entire product architecture is designed to feed the following infinite loop:

### The Primary Engine (Liquidity Loop)
1. **Supply Creation:** Player uploads high-quality basketball reel.
2. **Discovery:** AI Recommendation Engine serves the reel to a Coach.
3. **Action:** Coach "Swipes Right" or "Likes" the player.
4. **Connection:** Match is established → Chat/Call sequence initiates.
5. **Outcome:** Recruitment offer is made.
6. **Viral Catalyst:** Player shares success story (or profile) externally → Drives more players to the platform.

### Secondary Loop (Monetization Driver)
- Coach searches for highly specific talent (e.g., "PG, 6'2, >40% 3PT").
- Coach hits the daily interaction/search limit.
- Coach hits the paywall and converts to **Coach Pro**.

---

## 2. USER ACQUISITION SYSTEM

Organic acquisition heavily relies on **Player-Generated Content (PGC)** and **FOMO Triggers**.

### Viral Hooks & Triggers
- **Push Notifications:** *"A D1 Coach just viewed your profile."*
- **Social Sharing:** "View my full highlight tape and stats on Undiscovered Hoops" links routed through Branch.io for deep linking.
- **Rankings:** Regional player leaderboards creating competitive status sharing.

---

## 3. RECOMMENDATION ENGINE (THE "FEED" ALGORITHM)

Reels are served using a dynamically weighted formula to maximize watch time and match probability.

**Ranking Formula (Simplified):**
`Score = (Engagement_Time × 0.4) + (Role_Relevance × 0.3) + (Recency × 0.2) + (Social_Proximity × 0.1)`

- **Engagement:** Does the user watch the video > 80% of the way through? Do they replay it?
- **Relevance:** Does the coach historically recruit this position/height?
- **Social Proximity:** Are they in the same region, or do they share mutual connections?

---

## 4. MONETIZATION & PRICING ARCHITECTURE

We utilize a **Value-Gated Freemium Model**. The primary revenue driver is the Coach/Recruiter side of the marketplace.

### 4.1 Subscription Tiers
| Tier | Target User | Price Range | Core Value Proposition |
| :--- | :--- | :--- | :--- |
| **Free** | Players/Fans | $0 | Upload reels, basic matching, view feed. |
| **Player Pro** | Serious Athletes | $5 - $15 / mo | See who viewed your profile, algorithmic visibility boost. |
| **Coach Pro** | College Coaches | $20 - $50 / mo | Advanced search filters, unlimited direct messaging, priority matchmaking. |
| **School/Org** | Athletic Depts. | $100+ / mo | Multi-seat licenses, event promotion, talent pipeline CRM. |

### 4.2 Paywall Triggers
- **Players:** Trying to see the list of coaches who viewed their profile.
- **Coaches:** Swiping/messaging more than 5 players in a 24-hour window.
- **General:** Trying to view advanced proprietary analytics/stats on a profile.

### 4.3 Transactional Revenue
- In-app registration fees for partnered camps and tournaments (platform takes 5-10% cut).

---

## 5. RETENTION ENGINEERING (DAU DRIVERS)

If users don't return, the monetization loop breaks. We hook users back into the app using:

- **The Variable Reward:** Opening the app to see if any new Coaches have matched or viewed them.
- **Content Addiction:** An endless, high-quality, auto-playing short-video feed (TikTok-style UX).
- **Social Validation:** Push notifications explicitly designed around ego (e.g., *"Your latest reel is trending in your state."*).

---

## 6. NETWORK EFFECTS & MARKETPLACE DYNAMICS

Undiscovered Hoops is a multi-sided marketplace. Its value increases exponentially as users join:
- **More Players =** Better talent pool → Attracts more Coaches.
- **More Coaches =** Higher likelihood of recruitment → Attracts more Players.
- **More Events =** Real-world density → Attracts fans and organizations.

---

## 7. DATA-DRIVEN OPTIMIZATION & KPIs

### Core Metrics Tracked (Amplitude/Mixpanel)
- **Marketplace Liquidity:** % of users who get at least one match within 7 days.
- **Retention:** Day 1, Day 7, and Day 30 retention rates.
- **Conversion Rate:** Free → Pro upgrade percentage.
- **Session Length:** Average time spent in the Reels Feed.

### Risk Factors & Mitigations
| Risk | Mitigation |
| :--- | :--- |
| **Over-aggressive Paywall (Churn)** | Delay the paywall until the user receives their first Match (demonstrated value). |
| **Weak Coach Supply** | Offer 6 months free "Coach Pro" to verified NCAA coaches to seed the marketplace. |
| **Poor Match Quality** | Heavily weigh the recommendation algorithm toward geographic and positional relevance rather than just "likes". |
