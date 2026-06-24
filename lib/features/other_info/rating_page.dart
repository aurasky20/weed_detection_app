import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weedcheck/features/other_info/infosub_page.dart';
import 'package:weedcheck/features/other_info/widget/input_text.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _rating = 0;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sending = false;

  static const _targetEmail = 'aurasasi20@gmail.com';

  /// Basic email format check
  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  Future<void> _send() async {
    final email = _emailController.text.trim();

    if (_rating == 0) {
      _showSnackbar("Pilih rating terlebih dahulu", isError: true);
      return;
    }
    if (email.isEmpty) {
      _showSnackbar("Email tidak boleh kosong", isError: true);
      return;
    }
    if (!_isValidEmail(email)) {
      _showSnackbar("Format email tidak valid", isError: true);
      return;
    }
    if (_messageController.text.trim().isEmpty) {
      _showSnackbar("Pesan tidak boleh kosong", isError: true);
      return;
    }

    setState(() => _sending = true);

    final stars = '⭐' * _rating;
    final name = _nameController.text.trim().isEmpty
        ? 'Anonim'
        : _nameController.text.trim();

    final subject =
        Uri.encodeComponent('Rating WeedCheck: $_rating/5 $stars');
    final body = Uri.encodeComponent(
      'Nama   : $name\n'
      'Email  : $email\n'
      'Rating : $_rating/5 $stars\n\n'
      'Pesan:\n${_messageController.text.trim()}\n\n'
      '--- Dikirim dari WeedCheck App ---',
    );

    final uri = Uri.parse(
      'mailto:$_targetEmail?subject=$subject&body=$body',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      if (!mounted) return;
      _showSnackbar("Membuka aplikasi email...");
    } else {
      if (!mounted) return;
      _showSnackbar("Tidak dapat membuka aplikasi email", isError: true);
    }

    setState(() => _sending = false);
  }

  void _showSnackbar(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor:
            isError ? const Color(0xFFEF9651) : const Color(0xFF18230F),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
                  color: const Color(0xFF41B06E).withOpacity(0.12)),
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: 6),
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

          const SizedBox(height: 16),

          /// ── Name field (optional)
          InputField(
            controller: _nameController,
            label: "Nama (opsional)",
            hint: "Masukkan nama Anda...",
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            maxLines: 1,
          ),

          const SizedBox(height: 12),

          /// ── Email field (required)
          InputField(
            controller: _emailController,
            label: "Email Anda",
            hint: "contoh@email.com",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            isRequired: true,
          ),

          const SizedBox(height: 12),

          /// ── Message field (required)
          InputField(
            controller: _messageController,
            label: "Pesan & Masukan",
            hint:
                "Tulis pengalaman atau saran Anda untuk WeedCheck...",
            icon: Icons.edit_note_rounded,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            isRequired: true,
          ),

          const SizedBox(height: 20),

          /// ── Destination info chip
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FAF4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFF87D05F).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.send_rounded,
                    color: Color(0xFF41B06E), size: 14),
                const SizedBox(width: 8),
                Text(
                  "Dikirim ke: Tim Pengembang Aplikasi",
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF18230F).withOpacity(0.55),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          /// ── Send button
          GestureDetector(
            onTap: _sending ? null : _send,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _sending
                      ? [const Color(0xFF41B06E), const Color(0xFF41B06E)]
                      : [
                          const Color(0xFF246A40),
                          const Color(0xFF41B06E)
                        ],
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
                          Icon(Icons.send_rounded,
                              color: Color(0xFFFFDD34), size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Kirim via Email",
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

          const SizedBox(height: 10),

          Center(
            child: Text(
              "Akan membuka aplikasi email di perangkat Anda",
              style: TextStyle(
                fontSize: 11,
                color: const Color(0xFF18230F).withOpacity(0.35),
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

