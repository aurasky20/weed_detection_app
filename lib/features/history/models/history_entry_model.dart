class HistoryEntry {
  final String id;
  final String weedName;
  final String imagePath;
  final DateTime detectedAt;

  const HistoryEntry({
    required this.id,
    required this.weedName,
    required this.imagePath,
    required this.detectedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'weedName': weedName,
    'imagePath': imagePath,
    'detectedAt': detectedAt.toIso8601String(),
  };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    id: json['id'],
    weedName: json['weedName'],
    imagePath: json['imagePath'],
    detectedAt: DateTime.parse(json['detectedAt']),
  );
}
