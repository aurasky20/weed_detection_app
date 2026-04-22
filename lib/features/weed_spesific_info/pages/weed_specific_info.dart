import 'package:flutter/material.dart';
import '../../../core/data/gulma_data.dart';

class WeedSpecificInfo extends StatelessWidget {
  final Weed weed;

  const WeedSpecificInfo({required this.weed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// 🔝 HEADER
          Container(
            color: Colors.green[900],
            padding: EdgeInsets.only(top: 40, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),

                Text(
                  "Spesifikasi Gulma",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// 📜 CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 📷 GAMBAR
                  Image.network(
                    weed.image,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(height: 10),

                  /// 🌿 NAMA
                  Center(
                    child: Text(
                      weed.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  /// 🧪 HERBISIDA
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Herbisida:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(weed.herbiside),
                  ),

                  /// 📄 DESKRIPSI
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Deskripsi:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(weed.desc),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}