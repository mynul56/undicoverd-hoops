import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  Future<void> _launchStripeCheckout(String tier) async {
    // In production, this pings the NestJS /stripe/create-checkout-session endpoint first
    // For this demo, we launch a mock URL directly.
    final url = Uri.parse('https://checkout.stripe.com/pay/cs_test_mock_123_$tier');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch Stripe URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPGRADE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            const Text(
              'Unlock the full power of the Undiscovered Hoops recruiting network.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 40),
            
            // Player Pro Tier
            _PricingCard(
              title: 'PRO ATHLETE',
              price: '\$9.99',
              period: '/mo',
              features: ['Unlimited Event Applications', 'See Who Viewed Your Profile', 'Priority Highlight Positioning'],
              onTap: () => _launchStripeCheckout('PRO_ATHLETE'),
              color: const Color(0xFFE4FF00),
            ),
            
            const SizedBox(height: 24),
            
            // Coach Pro Tier
            _PricingCard(
              title: 'COACH PRO',
              price: '\$49',
              period: '/mo',
              features: ['Advanced Search Matrix', 'Direct Messaging to Athletes', 'Basic CRM Pipeline'],
              onTap: () => _launchStripeCheckout('COACH_PRO'),
              color: Colors.white,
            ),
            
            const SizedBox(height: 24),
            
            // Enterprise Tier
            _PricingCard(
              title: 'SCHOOL ENTERPRISE',
              price: '\$499',
              period: '/yr',
              features: ['Collaborative Recruiting Boards', 'Unlimited Staff Accounts', 'AI Match Recommendations'],
              onTap: () => _launchStripeCheckout('SCHOOL_ENTERPRISE'),
              color: Colors.blueAccent,
            ),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final VoidCallback onTap;
  final Color color;

  const _PricingCard({
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color, letterSpacing: 1)),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white)),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 4),
                child: Text(period, style: const TextStyle(color: Colors.white54, fontSize: 16)),
              ),
            ],
          ),
          const Divider(height: 48, color: Colors.white24),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: color, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(f, style: const TextStyle(color: Colors.white))),
              ],
            ),
          )),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('UPGRADE NOW', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
          )
        ],
      ),
    );
  }
}
