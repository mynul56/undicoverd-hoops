import { NestFactory } from '@nestjs/core';
import { MessagingServiceModule } from './messaging_service.module';

async function bootstrap() {
  const app = await NestFactory.create(MessagingServiceModule);
  await app.listen(process.env.port ?? 3000);
}
bootstrap();
