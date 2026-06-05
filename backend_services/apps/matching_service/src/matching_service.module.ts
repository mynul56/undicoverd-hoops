import { Module } from '@nestjs/common';
import { MatchingServiceController } from './matching_service.controller';
import { MatchingServiceService } from './matching_service.service';

@Module({
  imports: [],
  controllers: [MatchingServiceController],
  providers: [MatchingServiceService],
})
export class MatchingServiceModule {}
