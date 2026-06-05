import { Module } from '@nestjs/common';
import { MessagingServiceController } from './messaging_service.controller';
import { MessagingServiceService } from './messaging_service.service';

@Module({
  imports: [],
  controllers: [MessagingServiceController],
  providers: [MessagingServiceService],
})
export class MessagingServiceModule {}
