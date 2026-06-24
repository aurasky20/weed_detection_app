import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weedcheck/features/history/widgets/history_detail_page.dart';
import 'package:weedcheck/features/history/widgets/popup_delete_widget.dart';
import '../controller/history_controller.dart';
import '../widgets/history_card_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _controller = HistoryController();

  @override
  void initState() {
    super.initState();
    _controller.loadHistory();
    _controller.addListener(_onUpdate);
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onUpdate);
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await _controller.loadHistory();
  }

  Future<void> _confirmDelete(String id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteDialog(
        title: "Hapus Riwayat?",
        message: "Item ini akan dihapus permanen.",
      ),
    );

    if (ok == true) await _controller.deleteEntry(id);
  }

  Future<void> _confirmClearAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteDialog(
        title: "Hapus Semua?",
        message: "Seluruh riwayat akan dihapus permanen.",
        confirmText: "Hapus Semua",
      ),
    );

    if (ok == true) await _controller.clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6FBF7),
        body: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _controller.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF41B06E),
                      ),
                    )
                  : _controller.entries.isEmpty
                  ? _buildEmpty()
                  : RefreshIndicator(
                      color: const Color(0xFF41B06E),
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount: _controller.entries.length,
                        itemBuilder: (_, i) {
                          final entry = _controller.entries[i];
                          return HistoryCard(
                            entry: entry,
                            onDelete: () => _confirmDelete(entry.id),
                            onTap: () =>
                                Navigator.of(context, rootNavigator: true).push(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        HistoryDetailPage(entry: entry),
                                    transitionsBuilder:
                                        (_, animation, __, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                  ),
                                ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF246A40), Color(0xFF41B06E)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x3018230F),
            blurRadius: 8,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFFFDD34).withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Color(0xFFFFDD34),
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              // Judul
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Riwayat Deteksi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Hasil deteksi yang tersimpan',
                    style: TextStyle(
                      color: Color(0xFFFFE432),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Tombol hapus semua
              if (_controller.entries.isNotEmpty)
                GestureDetector(
                  onTap: _confirmClearAll,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.delete_sweep_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return ListView(
      // Pakai ListView agar RefreshIndicator tetap bisa ditarik saat kosong
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history_rounded,
              size: 72,
              color: const Color(0xFF87D05F).withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum ada riwayat deteksi',
              style: TextStyle(
                color: Color(0xFF8FB88A),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Hasil deteksi yang disimpan\nakan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFB0C8AA), fontSize: 13),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tarik ke bawah untuk memperbarui',
              style: TextStyle(color: Color(0xFFB0C8AA), fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
