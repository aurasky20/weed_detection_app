import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/result_page.dart';
import '../controllers/camera_controller.dart';
// import '../pages/preview_page.dart';

class BottomControls extends StatelessWidget {
  final CameraControllerX controller;
  final BuildContext parentContext;
  final VoidCallback onFlip;

  const BottomControls({
    required this.controller,
    required this.parentContext,
    required this.onFlip,
  });

  
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();


    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          
          children: [
            /// 📂 GALERI
            IconButton(
              icon: Icon(Icons.image, color: Colors.white, size: 30),
              onPressed: () async {
                final file = await picker.pickImage(source: ImageSource.gallery);

                if (file != null) {
                  try {
                    String result = await controller.detectImage(file.path);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResultPage(
                          result: result,
                          imagePath: file.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    print("ERROR DETEKSI: $e");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Gagal mendeteksi gambar")),
                    );
                  }
                }
              },
            ),

            /// 📸 CAPTURE
            GestureDetector(
              onTap: () async {
                final file = await controller.takePicture();

                if (file != null) {
                  try {
                    String result = await controller.detectImage(file.path);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResultPage(
                          result: result,
                          imagePath: file.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    print("ERROR DETEKSI: $e");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Gagal mendeteksi gambar")),
                    );
                  }
                }
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            /// 🔄 FLIP
            IconButton(
              icon: Icon(Icons.cameraswitch,
                  color: Colors.white, size: 30),
              onPressed: onFlip,
            ),
          ],
        ),
      ),
    );
  }
}