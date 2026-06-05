import { Controller, Get, Post, Body, UseInterceptors } from '@nestjs/common';
import { AuthServiceService } from './auth_service.service';
import { StandardResponseInterceptor } from '../../../libs/shared/src/interceptors/standard-response.interceptor';

@Controller('auth')
@UseInterceptors(StandardResponseInterceptor)
export class AuthServiceController {
  constructor(private readonly authService: AuthServiceService) {}

  @Post('login')
  login(@Body() body: any) {
    return {
      user: { id: '123', email: body.email, role: 'player' },
      accessToken: 'jwt_token_example',
    };
  }

  @Post('register')
  register(@Body() body: any) {
    return { id: '123', email: body.email };
  }

  @Post('logout')
  logout() {
    return { message: 'Logged out successfully' };
  }

  @Get('me')
  getMe() {
    return { id: '123', email: 'test@example.com' };
  }
}
