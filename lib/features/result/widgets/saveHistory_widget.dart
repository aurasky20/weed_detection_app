import 'package:flutter/material.dart';
import 'package:weedcheck/features/history/service/history_service.dart';


class SaveHistoryButton extends StatefulWidget {
  final String result;
  final String imagePath;

  const SaveHistoryButton({
    super.key,
    required this.result,
    required this.imagePath,
  });

  @override
  State<SaveHistoryButton> createState() => _SaveHistoryButtonState();
}

class _SaveHistoryButtonState extends State<SaveHistoryButton> {
  bool _saved = false;
  bool _loading = false;

  Future<void> _save() async {
    if (_saved || _loading) return;
    setState(() => _loading = true);

    final entry = HistoryEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      weedName: widget.result.isNotEmpty ? widget.result : "Tidak Dikenali",
      imagePath: widget.imagePath,
      detectedAt: DateTime.now(),
    );

    await HistoryService.save(entry);

    if (!mounted) return;
    setState(() {
      _loading = false;
      _saved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded,
                color: Color(0xFFFFDD34), size: 16),
            SizedBox(width: 8),
            Text(
              "Disimpan ke riwayat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF18230F),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _save,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: _saved
              ? const Color(0xFFF0FAF4)
              : const Color(0xFFF4FCF0),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _saved
                ? const Color(0xFF87D05F).withOpacity(0.5)
                : const Color(0xFF87D05F).withOpacity(0.35),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF41B06E),
                    ),
                  )
                : Icon(
                    _saved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: const Color(0xFF41B06E),
                    size: 18,
                  ),
            const SizedBox(width: 8),
            Text(
              _saved ? "Tersimpan" : "Simpan ke Riwayat",
              style: const TextStyle(
                color: Color(0xFF41B06E),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}