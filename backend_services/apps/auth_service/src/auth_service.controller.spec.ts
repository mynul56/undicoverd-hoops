import { Test, TestingModule } from '@nestjs/testing';
import { AuthServiceController } from './auth_service.controller';
import { AuthServiceService } from './auth_service.service';

describe('AuthServiceController', () => {
  let authServiceController: AuthServiceController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [AuthServiceController],
      providers: [
        {
          provide: AuthServiceService,
          useValue: {
            login: jest.fn(),
            register: jest.fn(),
          },
        },
      ],
    }).compile();

    authServiceController = app.get<AuthServiceController>(AuthServiceController);
  });

  describe('root', () => {
    it('should return mock user on getMe', () => {
      expect(authServiceController.getMe()).toEqual({ id: '123', email: 'test@example.com' });
    });
  });
});
