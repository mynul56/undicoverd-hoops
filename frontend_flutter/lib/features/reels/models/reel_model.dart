class ReelModel {
  final String id;
  final String videoUrl;
  final String playerFirstName;
  final String playerLastName;
  final String height;
  final String position;
  final int viewCount;

  ReelModel({
    required this.id,
    required this.videoUrl,
    required this.playerFirstName,
    required this.playerLastName,
    required this.height,
    required this.position,
    required this.viewCount,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'] as String,
      videoUrl: json['videoUrl'] as String,
      playerFirstName: json['playerFirstName'] as String,
      playerLastName: json['playerLastName'] as String,
      height: json['height'] as String,
      position: json['position'] as String,
      viewCount: json['viewCount'] as int? ?? 0,
    );
  }
}
