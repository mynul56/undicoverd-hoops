import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  OnGatewayConnection,
  OnGatewayDisconnect,
  MessageBody,
  ConnectedSocket,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway({ cors: { origin: '*' } })
export class CallsGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  // Simple in-memory map to track active users for signaling
  // In a distributed production system, this would use Redis.
  private activeUsers = new Map<string, string>(); // userId -> socketId

  handleConnection(client: Socket) {
    const userId = client.handshake.query.userId as string;
    if (userId) {
      this.activeUsers.set(userId, client.id);
      console.log(`[CallsGateway] User connected: ${userId} (Socket: ${client.id})`);
    }
  }

  handleDisconnect(client: Socket) {
    const userId = client.handshake.query.userId as string;
    if (userId) {
      this.activeUsers.delete(userId);
      console.log(`[CallsGateway] User disconnected: ${userId}`);
    }
  }

  @SubscribeMessage('call-offer')
  handleOffer(@MessageBody() payload: { targetUserId: string; offer: any; callerId: string }, @ConnectedSocket() client: Socket) {
    const targetSocket = this.activeUsers.get(payload.targetUserId);
    if (targetSocket) {
      this.server.to(targetSocket).emit('call-offer', {
        offer: payload.offer,
        callerId: payload.callerId,
      });
    }
  }

  @SubscribeMessage('call-answer')
  handleAnswer(@MessageBody() payload: { targetUserId: string; answer: any }, @ConnectedSocket() client: Socket) {
    const targetSocket = this.activeUsers.get(payload.targetUserId);
    if (targetSocket) {
      this.server.to(targetSocket).emit('call-answer', {
        answer: payload.answer,
      });
    }
  }

  @SubscribeMessage('ice-candidate')
  handleIceCandidate(@MessageBody() payload: { targetUserId: string; candidate: any }, @ConnectedSocket() client: Socket) {
    const targetSocket = this.activeUsers.get(payload.targetUserId);
    if (targetSocket) {
      this.server.to(targetSocket).emit('ice-candidate', {
        candidate: payload.candidate,
      });
    }
  }

  @SubscribeMessage('end-call')
  handleEndCall(@MessageBody() payload: { targetUserId: string }, @ConnectedSocket() client: Socket) {
    const targetSocket = this.activeUsers.get(payload.targetUserId);
    if (targetSocket) {
      this.server.to(targetSocket).emit('call-ended');
    }
  }
}
