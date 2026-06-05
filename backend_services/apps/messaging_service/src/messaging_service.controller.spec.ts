import { Test, TestingModule } from '@nestjs/testing';
import { MessagingServiceController } from './messaging_service.controller';
import { MessagingServiceService } from './messaging_service.service';

describe('MessagingServiceController', () => {
  let messagingServiceController: MessagingServiceController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [MessagingServiceController],
      providers: [MessagingServiceService],
    }).compile();

    messagingServiceController = app.get<MessagingServiceController>(MessagingServiceController);
  });

  describe('root', () => {
    it('should return "Hello World!"', () => {
      expect(messagingServiceController.getHello()).toBe('Hello World!');
    });
  });
});
