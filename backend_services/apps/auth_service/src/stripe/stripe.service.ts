import { Injectable } from '@nestjs/common';
import Stripe from 'stripe';
import { PrismaService } from '../prisma.service';

@Injectable()
export class StripeService {
  private stripe: Stripe;

  constructor(private prisma: PrismaService) {
    this.stripe = new Stripe(process.env.STRIPE_SECRET_KEY || 'sk_test_mock', {
      apiVersion: '2025-01-27.acacia',
    });
  }

  async createCheckoutSession(userId: string, tier: string) {
    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    if (!user) throw new Error('User not found');

    // Mapping custom tiers to mock price IDs
    let priceId = '';
    if (tier === 'PRO_ATHLETE') priceId = 'price_pro_athlete_mock';
    else if (tier === 'COACH_PRO') priceId = 'price_coach_pro_mock';
    else if (tier === 'SCHOOL_ENTERPRISE') priceId = 'price_school_enterprise_mock';
    else throw new Error('Invalid subscription tier');

    // MOCK: Generate a fake checkout session URL for local testing since we don't have real Stripe keys
    return {
      url: `https://checkout.stripe.com/pay/cs_test_mock_${userId}_${tier}`,
    };
  }

  async handleWebhook(signature: string, payload: any) {
    // In production, verify signature using this.stripe.webhooks.constructEvent()
    const event = payload;

    if (event.type === 'checkout.session.completed') {
      const session = event.data.object;
      const userId = session.client_reference_id;
      const tier = session.metadata?.tier || 'PRO_ATHLETE';

      if (userId) {
        await this.prisma.subscription.upsert({
          where: { userId },
          update: { tier: tier as any, status: 'active' },
          create: { userId, tier: tier as any, status: 'active' },
        });
      }
    }

    return { received: true };
  }
}
