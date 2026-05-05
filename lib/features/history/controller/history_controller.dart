import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_entry_model.dart';

class HistoryController extends ChangeNotifier {
  static const _key = 'weedcheck_history';

  // Singleton agar semua widget pakai instance yang sama
  static final HistoryController _instance = HistoryController._internal();
  factory HistoryController() => _instance;
  HistoryController._internal();

  List<HistoryEntry> _entries = [];
  bool _loading = false;

  List<HistoryEntry> get entries => List.unmodifiable(_entries);
  bool get loading => _loading;

  Future<void> loadHistory() async {
    _loading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];

    _entries = raw
        .map((e) => HistoryEntry.fromJson(jsonDecode(e)))
        .toList()
      ..sort((a, b) => b.detectedAt.compareTo(a.detectedAt));

    _loading = false;
    notifyListeners();
  }

  Future<bool> saveEntry({
    required String result,
    required String imagePath,
  }) async {
    try {
      // PENTING: Load dulu data terbaru dari SharedPreferences
      // sebelum menambahkan entry baru, agar tidak menimpa data lama
      final prefs = await SharedPreferences.getInstance();
      final existing = prefs.getStringList(_key) ?? [];
      _entries = existing
          .map((e) => HistoryEntry.fromJson(jsonDecode(e)))
          .toList()
        ..sort((a, b) => b.detectedAt.compareTo(a.detectedAt));

      final savedPath = await _copyImageToAppDir(imagePath);

      final entry = HistoryEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        weedName: result.isNotEmpty ? result : 'Tidak Dikenali',
        imagePath: savedPath,
        detectedAt: DateTime.now(),
      );

      _entries.insert(0, entry);
      await _persist();
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> deleteEntry(String id) async {
    final idx = _entries.indexWhere((e) => e.id == id);
    if (idx == -1) return;

    final file = File(_entries[idx].imagePath);
    if (await file.exists()) await file.delete();

    _entries.removeAt(idx);
    await _persist();
    notifyListeners();
  }

  Future<void> clearAll() async {
    for (final e in _entries) {
      final file = File(e.imagePath);
      if (await file.exists()) await file.delete();
    }
    _entries.clear();
    await _persist();
    notifyListeners();
  }

  Future<String> _copyImageToAppDir(String sourcePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final historyDir = Directory(p.join(appDir.path, 'weedcheck_history'));
    if (!await historyDir.exists()) await historyDir.create(recursive: true);

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final dest = p.join(historyDir.path, fileName);
    await File(sourcePath).copy(dest);
    return dest;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = _entries.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, raw);
  }
}