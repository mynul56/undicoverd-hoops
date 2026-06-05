import { Controller, Post, Body, Headers, HttpCode } from '@nestjs/common';
import { StripeService } from './stripe.service';

@Controller('stripe')
export class StripeController {
  constructor(private readonly stripeService: StripeService) {}

  @Post('create-checkout-session')
  async createCheckoutSession(@Body() body: { userId: string, tier: string }) {
    return this.stripeService.createCheckoutSession(body.userId, body.tier);
  }

  @Post('webhook')
  @HttpCode(200)
  async handleWebhook(@Headers('stripe-signature') signature: string, @Body() payload: any) {
    return this.stripeService.handleWebhook(signature, payload);
  }
}
