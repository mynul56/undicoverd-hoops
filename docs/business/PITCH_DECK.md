# UNDISCOVERED HOOPS: INVESTOR PITCH DECK & BUSINESS MODEL
**Status:** Venture-Ready | **Target:** Seed Round ($500K - $2M)

This document is the quantitative foundation for the Undiscovered Hoops SaaS ecosystem. It defines the pitch, the TAM, unit economics, revenue scaling, and risk mitigations required for venture funding.

---

## PART 1: THE PITCH DECK (12-SLIDE MODEL)

### Slide 1: Title
**Undiscovered Hoops**
*The Global Sports Recruiting & Social Network Platform*

### Slide 2: The Problem
- **Hidden Talent:** Millions of amateur and high school basketball players go completely undiscovered due to geographic or financial limitations.
- **Coach Inefficiency:** College recruiters and professional scouts lack a centralized, video-first talent discovery tool.
- **Fragmented Ecosystem:** Recruiting is currently broken across disparate tools—Instagram DMs, expensive pay-to-play showcases, and static email blasts.

### Slide 3: The Solution
A unified, real-time platform merging social discovery with SaaS recruiting tools.
- **Player Showcase System:** TikTok-style highlights optimized for algorithmic discovery.
- **Coach Discovery Engine:** Tinder-style swiping and filtering based on verified stats, height, and position.
- **Real-Time Pipeline:** Integrated WebSocket messaging and WebRTC video calls to close the recruitment gap.

### Slide 4: The Product
**Core Modules:**
- `Reels:` Short-form video scouting with engagement algorithms.
- `Match System:` Mutual-interest matching algorithms.
- `Communications:` Native Chat + Video Calls.
- `Marketplace:` Event and camp registration.
- `SaaS Layer:` Subscription-gated access and analytics.

### Slide 5: Market Size (TAM/SAM/SOM)
| Segment | Scope | Estimated Value |
| :--- | :--- | :--- |
| **TAM** | Global SportsTech Market | $30B+ |
| **SAM** | Athletic Recruiting Tech | $10B+ |
| **SOM** | Amateur Basketball Demographic | Multi-million active users |

### Slide 6: Business Model
Undiscovered Hoops is a **two-sided marketplace** powered by SaaS subscriptions and transactional fees.
- **Coach Subscriptions (Primary):** B2B monthly recurring revenue (MRR) for recruitment access.
- **Player Premium (Secondary):** B2C freemium upgrades for visibility boosts.
- **Event Fees:** Platform cut for camp and tournament registrations.
- **Featured Listings:** Pay-per-click profile or reel boosting.

### Slide 7: Traction Model
- **Growth Engine:** Viral, player-generated highlight reels shared cross-platform (TikTok/IG) driving organic app installs.
- **Revenue Engine:** Direct outreach to coaching staff converting free searches into paid subscriptions.
- **Engagement Spikes:** Seasonal AAU tournaments and recruiting windows drive massive concurrent user spikes.

### Slide 8: Unit Economics (The Growth Math)
**Core Assumptions:**
- **CAC (Coach):** $20 - $60 (via targeted LinkedIn/Email outreach).
- **ARPU (Coach):** $30 / month.
- **Lifetime (Retention):** 10 months average (6 - 18 month range).
- **LTV Calculation:** $30 × 10 = $300 average LTV.

**Economic Health:**
- **LTV:CAC Ratio:** $300 / $40 = **7.5x** (Highly venture-fundable; >3x is the SaaS gold standard).

### Slide 9: Competition
- **Current Alternatives:** Hudl (expensive, rigid), Instagram (noisy, no stats), Email (low conversion).
- **Our Moat:** We are the *only* vertically integrated, basketball-specific social recruiting platform with native video streaming and matching mechanics.

### Slide 10: Go-To-Market Strategy
1. **Supply Side (Organic):** Player-led viral sharing of profile cards. 
2. **Demand Side (Direct):** Direct sales to D2/D3, NAIA, and JUCO coaches who lack massive recruiting budgets.
3. **Partnerships:** Strategic alliances with AAU circuits and summer camps for bulk onboarding.

### Slide 11: Financial Forecast
| Year | Coaches (Paying) | Players (Active) | Est. ARR (Annual Run Rate) |
| :--- | :--- | :--- | :--- |
| **Year 1** | 5,000 | 50,000 | $500K - $1M |
| **Year 2** | 20,000 | 200,000 | $3M - $5M |
| **Year 3** | 100,000+ | 1,000,000+ | $10M - $25M |

### Slide 12: The Ask
**Raising:** $500K – $2M Seed Round.
**Use of Funds:**
- 40% Infrastructure Scaling (Video transcode, WebRTC).
- 30% User Acquisition & Marketing (Coach B2B sales).
- 20% AI & Matching System Development.
- 10% Global Expansion & Localization.

---

## PART 2: SYSTEMATIC BUSINESS LOGIC

### 1. Profitability Condition
The platform achieves operational break-even when:
`[Coach MRR + Event Revenue] > [AWS Infrastructure Costs (Video + DB) + Blended CAC + Payroll]`
Video streaming (CloudFront egress) is our primary variable cost; unit profitability relies on maintaining the 7.5x LTV:CAC ratio.

### 2. Investment Thesis
This platform dominates if and only if:
1. Coaches recognize the ROI and willingly cross the paywall for access to players.
2. Players generate continuous, viral, high-quality video content to solve the "cold start" marketplace problem.
3. Successful matches create retention loops and powerful testimonials.

### 3. Risk Analysis & Mitigation
- **Risk:** Weak coach acquisition leads to revenue collapse.
  - **Mitigation:** Subsidize initial 1,000 coaches with free lifetime access to guarantee demand liquidity for players.
- **Risk:** High infrastructure costs for video hosting and WebRTC.
  - **Mitigation:** Aggressively optimize AWS Elemental MediaConvert profiles and aggressively cache top-feed reels at edge locations.
- **Risk:** Market Fragmentation.
  - **Mitigation:** Vertically focus exclusively on Basketball before attempting horizontal expansion to other sports.

### 4. Exit Strategy
Targeted acquisition timeline: 5–7 years.
- **Media Acquirers:** Overtime, ESPN, Bleacher Report seeking gen-Z athletic communities.
- **SaaS Acquirers:** Hudl, NCSA, or TeamSnap seeking a modernized UI/UX and social engine.
- **Social Acquirers:** Meta or TikTok expanding into niche vertical networks.
