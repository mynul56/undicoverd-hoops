import { Module } from '@nestjs/common';
import { MessagingServiceController } from './messaging_service.controller';
import { MessagingServiceService } from './messaging_service.service';
import { MessagingGateway } from './messaging.gateway';

@Module({
  imports: [],
  controllers: [MessagingServiceController],
  providers: [MessagingServiceService, MessagingGateway],
})
export class MessagingServiceModule {}
