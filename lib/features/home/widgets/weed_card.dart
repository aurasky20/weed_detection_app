import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../../core/data/gulma_data.dart';
import '../../weed_spesific_info/pages/weed_specific_info.dart';

class WeedCard extends StatelessWidget {
  final Weed weed;

  const WeedCard({required this.weed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 🔥 PINDAH HALAMAN + KIRIM DATA
        pushScreen(
          context,
          screen: WeedSpecificInfo(weed: weed),

          /// 🔥 INI YANG PENTING
          withNavBar: false,
        );
      },

      child: Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            /// 📷 IMAGE
            Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(weed.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 5),

            /// 📝 NAME
            Text(
              weed.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}