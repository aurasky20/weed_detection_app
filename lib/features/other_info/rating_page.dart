import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weedcheck/features/other_info/Model/data_rating.dart';
import 'package:weedcheck/features/other_info/infosub_page.dart';
import 'package:weedcheck/features/other_info/widget/input_text.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  void initState() {
    super.initState();
    _loadRating();
  }

  int _rating = 0;
  final _messageController = TextEditingController();
  bool _sending = false;

  Future<void> _saveRating() async {
    FocusScope.of(context).unfocus();

    if (_rating == 0) {
      _showSnackbar("Pilih rating terlebih dahulu", isError: true);
      return;
    }

    final box = Hive.box<RatingModel>('ratings');

    await box.put(
      'user_rating',
      RatingModel(
        rating: _rating,
        message: _messageController.text.trim(),
        createdAt: DateTime.now(),
      ),
    );

    _showSnackbar("Terima kasih atas masukannya!");

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  Future<void> _loadRating() async {
    final box = Hive.box<RatingModel>('ratings');

    final ratingData = box.get('user_rating');

    if (ratingData != null) {
      setState(() {
        _rating = ratingData.rating;
        _messageController.text = ratingData.message;
      });
    }
  }

  void _showSnackbar(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: isError
            ? const Color(0xFFEF9651)
            : const Color(0xFF18230F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfoSubpageScaffold(
      title: "Beri Rating",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ── Star selector
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF41B06E).withOpacity(0.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF41B06E).withOpacity(0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  _rating == 0
                      ? "Ketuk bintang untuk memberi nilai"
                      : _ratingLabel(_rating),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _rating == 0
                        ? const Color(0xFF18230F).withOpacity(0.4)
                        : const Color(0xFF41B06E),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    final active = i < _rating;
                    return GestureDetector(
                      onTap: () => setState(() => _rating = i + 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          active
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: active
                              ? const Color(0xFFFFDD34)
                              : const Color(0xFF18230F).withOpacity(0.2),
                          size: 44,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// ── Message field (required)
          InputField(
            controller: _messageController,
            label: "Pesan & Masukan (Opsional)",
            hint: "Tuliskan pengalaman atau saran Anda (opsional)...",
            icon: Icons.edit_note_rounded,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            isRequired: false,
          ),

          const SizedBox(height: 20),

          /// ── Send button
          GestureDetector(
            onTap: _saveRating,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _sending
                      ? [const Color(0xFF41B06E), const Color(0xFF41B06E)]
                      : [const Color(0xFF246A40), const Color(0xFF41B06E)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF41B06E).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: _sending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.send_rounded,
                            color: Color(0xFFFFDD34),
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Simpan Masukkan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _ratingLabel(int r) {
    switch (r) {
      case 1:
        return "😞 Sangat Buruk";
      case 2:
        return "😐 Kurang Memuaskan";
      case 3:
        return "🙂 Cukup Baik";
      case 4:
        return "😊 Bagus";
      case 5:
        return "🤩 Luar Biasa!";
      default:
        return "";
    }
  }
}
