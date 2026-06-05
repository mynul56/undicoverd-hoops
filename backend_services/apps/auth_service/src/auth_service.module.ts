import { Module } from '@nestjs/common';
import { AuthServiceController } from './auth_service.controller';
import { AuthServiceService } from './auth_service.service';
import { PrismaService } from './prisma.service';
import { JwtModule } from '@nestjs/jwt';
import { CallsModule } from './calls/calls.module';

@Module({
  imports: [
    JwtModule.register({
      secret: 'super-secret-jwt-key', // Hardcoded for scaffold brevity; should use env
      signOptions: { expiresIn: '1h' },
    }),
    CallsModule,
  ],
  controllers: [AuthServiceController],
  providers: [AuthServiceService, PrismaService],
})
export class AuthServiceModule {}
