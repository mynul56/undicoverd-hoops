import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'dart:convert';

typedef StreamStateCallback = void Function(MediaStream stream);

class SignalingService {
  io.Socket? _socket;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;

  final String _serverUrl = 'http://localhost:3000'; // Hardcoded for local dev

  StreamStateCallback? onLocalStream;
  StreamStateCallback? onRemoteStream;
  Function()? onCallEnded;

  String? _myUserId;
  String? _targetUserId;

  Future<void> connect(String userId) async {
    _myUserId = userId;
    _socket = io.io(_serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'query': {'userId': userId},
      'autoConnect': false,
    });

    _socket?.connect();

    _socket?.onConnect((_) {
      print('Signaling connected as $userId');
    });

    _socket?.on('call-offer', (data) async {
      await _handleOffer(data);
    });

    _socket?.on('call-answer', (data) async {
      await _handleAnswer(data);
    });

    _socket?.on('ice-candidate', (data) async {
      await _handleIceCandidate(data);
    });

    _socket?.on('call-ended', (_) {
      endCall();
    });
  }

  Future<void> initiateCall(String targetUserId) async {
    _targetUserId = targetUserId;
    await _createPeerConnection();

    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    _socket?.emit('call-offer', {
      'targetUserId': targetUserId,
      'callerId': _myUserId,
      'offer': offer.toMap(),
    });
  }

  Future<void> _handleOffer(Map<String, dynamic> data) async {
    _targetUserId = data['callerId'];
    await _createPeerConnection();

    final offer = RTCSessionDescription(data['offer']['sdp'], data['offer']['type']);
    await _peerConnection!.setRemoteDescription(offer);

    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    _socket?.emit('call-answer', {
      'targetUserId': _targetUserId,
      'answer': answer.toMap(),
    });
  }

  Future<void> _handleAnswer(Map<String, dynamic> data) async {
    final answer = RTCSessionDescription(data['answer']['sdp'], data['answer']['type']);
    await _peerConnection!.setRemoteDescription(answer);
  }

  Future<void> _handleIceCandidate(Map<String, dynamic> data) async {
    final candidateData = data['candidate'];
    final candidate = RTCIceCandidate(
      candidateData['candidate'],
      candidateData['sdpMid'],
      candidateData['sdpMLineIndex'],
    );
    await _peerConnection?.addCandidate(candidate);
  }

  Future<void> _createPeerConnection() async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    };

    _peerConnection = await createPeerConnection(configuration);

    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      if (candidate.candidate != null) {
        _socket?.emit('ice-candidate', {
          'targetUserId': _targetUserId,
          'candidate': candidate.toMap(),
        });
      }
    };

    _peerConnection!.onAddStream = (MediaStream stream) {
      _remoteStream = stream;
      onRemoteStream?.call(stream);
    };

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {'facingMode': 'user'},
    });

    onLocalStream?.call(_localStream!);
    _peerConnection!.addStream(_localStream!);
  }

  void endCall() {
    if (_targetUserId != null) {
      _socket?.emit('end-call', {'targetUserId': _targetUserId});
    }
    
    _localStream?.getTracks().forEach((track) => track.stop());
    _peerConnection?.close();
    _peerConnection = null;
    _localStream = null;
    _remoteStream = null;
    _targetUserId = null;
    
    onCallEnded?.call();
  }

  void dispose() {
    endCall();
    _socket?.disconnect();
    _socket?.dispose();
  }
}
