import { Controller, Post, Body, Get, Query } from '@nestjs/common';
import { MatchesService } from './matches.service';

@Controller('matches')
export class MatchesController {
  constructor(private readonly matchesService: MatchesService) {}

  @Post('like')
  async likePlayer(
    @Body('coachId') coachId: string,
    @Body('playerId') playerId: string,
  ) {
    return this.matchesService.likePlayer(coachId, playerId);
  }

  @Post('player-like')
  async playerLikeCoach(
    @Body('playerId') playerId: string,
    @Body('coachId') coachId: string,
  ) {
    return this.matchesService.playerLikeCoach(playerId, coachId);
  }

  @Get()
  async getMatches(@Query('userId') userId: string, @Query('role') role: string) {
    return this.matchesService.getMatches(userId, role);
  }
}
