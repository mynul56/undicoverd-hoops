import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthServiceService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async register(body: any) {
    const { email, password, role } = body;
    
    const existingUser = await this.prisma.user.findUnique({ where: { email } });
    if (existingUser) throw new BadRequestException('User already exists');

    const passwordHash = await bcrypt.hash(password, 10);
    const userRole = role?.toUpperCase() === 'COACH' ? 'COACH' : 'PLAYER';
    const user = await this.prisma.user.create({
      data: { email, passwordHash, role: userRole },
    });

    const token = this.jwtService.sign({ userId: user.id, role: user.role });
    return { user: { id: user.id, email: user.email, role: user.role }, accessToken: token };
  }

  async login(body: any) {
    const { email, password } = body;
    const user = await this.prisma.user.findUnique({ where: { email } });
    
    if (!user) throw new UnauthorizedException('Invalid credentials');

    const isValid = await bcrypt.compare(password, user.passwordHash);
    if (!isValid) throw new UnauthorizedException('Invalid credentials');

    const token = this.jwtService.sign({ userId: user.id, role: user.role });
    return { user: { id: user.id, email: user.email, role: user.role }, accessToken: token };
  }
}
