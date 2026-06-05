import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../bloc/call_bloc.dart';
import '../bloc/call_event.dart';
import '../bloc/call_state.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<CallBloc, CallState>(
        listener: (context, state) {
          if (state is CallActive) {
            if (state.localStream != null && _localRenderer.srcObject != state.localStream) {
              _localRenderer.srcObject = state.localStream;
            }
            if (state.remoteStream != null && _remoteRenderer.srcObject != state.remoteStream) {
              _remoteRenderer.srcObject = state.remoteStream;
            }
          }
        },
        builder: (context, state) {
          if (state is CallIdle) {
            return const Center(child: Text('Call Ended', style: TextStyle(color: Colors.white)));
          }

          if (state is CallActive) {
            return Stack(
              children: [
                // Remote Stream (Fullscreen)
                Positioned.fill(
                  child: state.remoteStream != null
                      ? RTCVideoView(_remoteRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)
                      : const Center(child: CircularProgressIndicator(color: Colors.white)),
                ),
                
                // Local Stream (PIP)
                Positioned(
                  right: 20,
                  top: 60,
                  width: 120,
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: Colors.grey.shade900,
                      child: state.localStream != null
                          ? RTCVideoView(_localRenderer, mirror: true, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),

                // Controls
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: 'mic',
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        onPressed: () {
                          // Toggle Mic logic
                        },
                        child: const Icon(Icons.mic_off, color: Colors.white),
                      ),
                      FloatingActionButton(
                        heroTag: 'end_call',
                        backgroundColor: Colors.red,
                        onPressed: () {
                          context.read<CallBloc>().add(EndCall());
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.call_end, color: Colors.white),
                      ),
                      FloatingActionButton(
                        heroTag: 'camera',
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        onPressed: () {
                          // Toggle Camera logic
                        },
                        child: const Icon(Icons.cameraswitch, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
