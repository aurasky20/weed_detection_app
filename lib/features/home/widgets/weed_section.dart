import 'package:flutter/material.dart';
import '../../../core/data/gulma_data.dart';
import 'weed_card.dart';

// Halaman ini menampilkan daftar gulma berdasarkan kategori (daun lebar atau daun sempit). Data gulma diambil dari GulmaData dan ditampilkan dalam bentuk kartu horizontal.
class WeedSection extends StatelessWidget {
  final String title;

  const WeedSection({required this.title});

  @override
  Widget build(BuildContext context) {
    final weeds = GulmaData.data[title] ?? [];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 10),

          /// 🔹 CARD HORIZONTAL (DARI DATA)
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weeds.length,
              itemBuilder: (context, index) {
                return WeedCard(
                  weed: weeds[index], // 🔥 kirim object
                );
              },),
          ),
        ],
      ),
    );
  }
}