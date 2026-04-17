import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weedcheck/features/camera_detection/presentation/pages/result_page.dart';
import '../../controllers/camera_controller.dart';
import '../pages/preview_page.dart';

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
  Navigator.push(
    parentContext,
    MaterialPageRoute(
      builder: (_) => ResultPage(imagePath: file.path),
    ),
  );
}
              },
            ),

            /// 📸 CAPTURE
            GestureDetector(
              onTap: () async {
  final file = await controller.takePicture();

  if (file != null) {
    Navigator.push(
      parentContext,
      MaterialPageRoute(
        builder: (_) => ResultPage(imagePath: file.path),
      ),
    );
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