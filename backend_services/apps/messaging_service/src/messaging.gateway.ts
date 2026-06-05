import {
  WebSocketGateway,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  OnGatewayConnection,
  OnGatewayDisconnect,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway({ cors: true })
export class MessagingGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  handleConnection(client: Socket) {
    console.log(`Client connected: ${client.id}`);
    // TODO: Extract JWT from client.handshake.auth.token and store user session
  }

  handleDisconnect(client: Socket) {
    console.log(`Client disconnected: ${client.id}`);
    // TODO: Remove user session from Redis
  }

  @SubscribeMessage('send_message')
  handleMessage(@MessageBody() data: { toUserId: string; text: string }, @ConnectedSocket() client: Socket) {
    console.log('Received message:', data);
    // TODO: Save to DB
    // Emit to specific user
    // this.server.to(data.toUserId).emit('receive_message', data);
    return { status: 'sent' };
  }

  // WebRTC Signaling Events
  @SubscribeMessage('call_offer')
  handleCallOffer(@MessageBody() data: { toUserId: string; offer: any }, @ConnectedSocket() client: Socket) {
    console.log('Call offer to', data.toUserId);
    // this.server.to(data.toUserId).emit('incoming_call', { from: client.id, offer: data.offer });
  }

  @SubscribeMessage('call_answer')
  handleCallAnswer(@MessageBody() data: { toUserId: string; answer: any }, @ConnectedSocket() client: Socket) {
    console.log('Call answer to', data.toUserId);
    // this.server.to(data.toUserId).emit('call_answered', { answer: data.answer });
  }

  @SubscribeMessage('ice_candidate')
  handleIceCandidate(@MessageBody() data: { toUserId: string; candidate: any }, @ConnectedSocket() client: Socket) {
    // this.server.to(data.toUserId).emit('new_ice_candidate', { candidate: data.candidate });
  }
}
