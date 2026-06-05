import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { MatchStatus } from '@prisma/client';

@Injectable()
export class MatchesService {
  constructor(private prisma: PrismaService) {}

  async likePlayer(coachId: string, playerId: string) {
    // Check if match already exists
    let match = await this.prisma.match.findUnique({
      where: {
        coachId_playerId: { coachId, playerId },
      },
    });

    if (match) {
      if (match.status === MatchStatus.ACCEPTED) {
        return { message: 'Already matched!', match };
      }
      return { message: 'Already saved/liked!', match };
    }

    // Create a new PENDING match (Coach saved Player)
    match = await this.prisma.match.create({
      data: {
        coachId,
        playerId,
        status: MatchStatus.PENDING,
      },
    });

    return { message: 'Player saved!', match };
  }

  async playerLikeCoach(playerId: string, coachId: string) {
    // Player likes back
    const match = await this.prisma.match.findUnique({
      where: {
        coachId_playerId: { coachId, playerId },
      },
    });

    if (!match) {
      // For now, players can only like coaches who liked them first, or we create a reverse concept.
      // We'll just create a pending match conceptually, but let's assume they only see coaches who liked them.
      throw new BadRequestException('Coach has not liked you yet.');
    }

    if (match.status === MatchStatus.PENDING) {
      const updatedMatch = await this.prisma.match.update({
        where: { id: match.id },
        data: { status: MatchStatus.ACCEPTED },
      });
      return { message: 'Mutual match achieved!', match: updatedMatch };
    }

    return { message: 'Already matched!', match };
  }

  async getMatches(userId: string, role: string) {
    if (role === 'coach') {
      return this.prisma.match.findMany({
        where: { coachId: userId },
        include: { player: { include: { profile: true } } },
      });
    } else {
      return this.prisma.match.findMany({
        where: { playerId: userId },
        include: { coach: { include: { profile: true } } },
      });
    }
  }
}
