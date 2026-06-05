import '../../features/reels/models/reel_model.dart';

class DemoData {
  static final List<ReelModel> demoReels = [
    ReelModel(
      id: 'demo_player_1',
      videoUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      playerFirstName: 'Jalen',
      playerLastName: 'Green',
      height: '6\'5"',
      position: 'Shooting Guard',
      viewCount: 14200,
    ),
    ReelModel(
      id: 'demo_player_2',
      videoUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      playerFirstName: 'Chet',
      playerLastName: 'Holmgren',
      height: '7\'1"',
      position: 'Center',
      viewCount: 32000,
    ),
    ReelModel(
      id: 'demo_player_3',
      videoUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      playerFirstName: 'Scoot',
      playerLastName: 'Henderson',
      height: '6\'2"',
      position: 'Point Guard',
      viewCount: 18500,
    ),
  ];

  static const Map<String, dynamic> demoMatchResponse = {
    'message': 'Mutual match achieved!',
    'match': {
      'id': 'demo_match_123',
    }
  };
  
  static const Map<String, dynamic> demoSaveResponse = {
    'message': 'Player saved!',
    'match': {
      'id': 'demo_pending_123',
    }
  };
}
