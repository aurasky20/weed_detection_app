import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../result/pages/result_page.dart';
import '../controllers/camera_controller.dart';

class BottomControls extends StatefulWidget {
  final CameraControllerX controller;
  final BuildContext parentContext;
  final VoidCallback onFlip;

  const BottomControls({
    required this.controller,
    required this.parentContext,
    required this.onFlip,
  });

  @override
  State<BottomControls> createState() => _BottomControlsState();
}

class _BottomControlsState extends State<BottomControls> {
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// 📂 GALERI
              IconButton(
                icon: Icon(Icons.image, color: Colors.white, size: 30),
                onPressed: () async {
                  final file =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (file != null) {
                    try {
                      String result =
                          await widget.controller.detectImage(file.path);

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
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(
                      child:
                          CircularProgressIndicator(color: Colors.white),
                    ),
                  );

                  final file = await widget.controller.takePicture();

                  if (context.mounted) Navigator.of(context).pop();

                  if (file != null) {
                    try {
                      String result =
                          await widget.controller.detectImage(file.path);

                      if (context.mounted) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResultPage(
                              result: result,
                              imagePath: file.path,
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Gagal mendeteksi gambar")),
                        );
                      }
                    }

                    if (widget.controller.cameraController != null) {
                      widget.controller.cameraController!
                          .startImageStream((image) {
                        widget.controller.processFrame(image);
                      });
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
                      decoration: const BoxDecoration(
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
                onPressed: widget.onFlip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}