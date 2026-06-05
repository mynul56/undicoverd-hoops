import { Test, TestingModule } from '@nestjs/testing';
import { MediaServiceController } from './media_service.controller';
import { MediaServiceService } from './media_service.service';

describe('MediaServiceController', () => {
  let mediaServiceController: MediaServiceController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [MediaServiceController],
      providers: [MediaServiceService],
    }).compile();

    mediaServiceController = app.get<MediaServiceController>(MediaServiceController);
  });

  describe('root', () => {
    it('should return "Hello World!"', () => {
      expect(mediaServiceController.getHello()).toBe('Hello World!');
    });
  });
});
