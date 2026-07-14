import 'package:flutter/material.dart';
import 'package:weedcheck/features/result/widgets/popup_save_widget.dart';
import '../../../features/history/controller/history_controller.dart';

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

  // Cek apakah hasil deteksi valid (terdeteksi gulma)
  bool get _canSave {
  final result = widget.result.toLowerCase();

  return result.isNotEmpty &&
      !result.contains('tidak') &&
      !result.contains('unknown') &&
      !result.contains('not') &&
      !result.contains('too dark') &&
      !result.contains('gelap');
}

  Future<void> _onTap() async {
    if (_saved || _loading || !_canSave) return;

    // Tampilkan dialog konfirmasi
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => SaveDialog(result: widget.result),
    );

    if (ok != true || !mounted) return;

    setState(() => _loading = true);

    final controller = HistoryController();
    final success = await controller.saveEntry(
      result: widget.result,
      imagePath: widget.imagePath,
    );

    if (!mounted) return;
    setState(() {
      _loading = false;
      if (success) _saved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              success
                  ? Icons.check_circle_rounded
                  : Icons.error_outline_rounded,
              color: const Color(0xFFFFDD34),
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              success ? 'Berhasil disimpan ke riwayat' : 'Gagal menyimpan ke riwayat',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF18230F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Jika tidak terdeteksi, tombol non-aktif
    if (!_canSave) {
      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFDDDDDD)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark, color: Color(0xFFBBBBBB), size: 18),
            SizedBox(width: 8),
            Text(
              'Tidak Dapat Disimpan',
              style: TextStyle(
                color: Color(0xFFBBBBBB),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: _saved ? const Color(0xFFF0FAF4) : const Color(0xFFF4FCF0),
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
              _saved ? 'Berhasil disimpan' : 'Simpan ke Riwayat',
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
