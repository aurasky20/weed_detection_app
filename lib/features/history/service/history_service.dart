import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
    id: json['id'] as String,
    weedName: json['weedName'] as String,
    imagePath: json['imagePath'] as String,
    detectedAt: DateTime.parse(json['detectedAt'] as String),
  );
}

class HistoryService {
  static const _key = 'weedcheck_history';

  /// Load all history entries (newest first)
  static Future<List<HistoryEntry>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw
        .map((e) => HistoryEntry.fromJson(jsonDecode(e)))
        .toList()
        .reversed
        .toList();
  }

  /// Save a new entry to history
  static Future<void> save(HistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    raw.add(jsonEncode(entry.toJson()));
    await prefs.setStringList(_key, raw);
  }

  /// Delete a single entry by id
  static Future<void> delete(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    raw.removeWhere((e) {
      final map = jsonDecode(e) as Map<String, dynamic>;
      return map['id'] == id;
    });
    await prefs.setStringList(_key, raw);
  }

  /// Clear all history
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
