import { Module } from '@nestjs/common';
import { AuthServiceController } from './auth_service.controller';
import { AuthServiceService } from './auth_service.service';
import { PrismaService } from './prisma.service';
import { JwtModule } from '@nestjs/jwt';
import { CallsModule } from './calls/calls.module';
import { MatchesModule } from './matches/matches.module';
import { StripeModule } from './stripe/stripe.module';

@Module({
  imports: [
    JwtModule.register({
      secret: 'super-secret-jwt-key', // Hardcoded for scaffold brevity; should use env
      signOptions: { expiresIn: '1h' },
    }),
    CallsModule,
    MatchesModule,
    StripeModule,
  ],
  controllers: [AuthServiceController],
  providers: [AuthServiceService, PrismaService],
})
export class AuthServiceModule {}
