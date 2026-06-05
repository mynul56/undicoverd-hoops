import { Module } from '@nestjs/common';
import { MediaServiceController } from './media_service.controller';
import { MediaServiceService } from './media_service.service';

@Module({
  imports: [],
  controllers: [MediaServiceController],
  providers: [MediaServiceService],
})
export class MediaServiceModule {}
