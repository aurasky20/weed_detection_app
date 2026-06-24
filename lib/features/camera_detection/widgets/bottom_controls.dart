import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weedcheck/features/result/pages/result_page.dart';
import 'package:weedcheck/features/tutorial/camera_tutorial.dart';
import '../controllers/camera_controller.dart';

class BottomControls extends StatefulWidget {
  final CameraControllerX controller;
  final BuildContext parentContext;
  final VoidCallback onFlip;
  final dynamic galleryKey;
  final dynamic flipKey;
  final dynamic captureKey;

  const BottomControls({
    required this.controller,
    required this.parentContext,
    required this.onFlip,
    required this.galleryKey,
    required this.flipKey,
    required this.captureKey,
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
      padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// =========================
          /// GALLERY
          /// =========================
          CameraTutorial.tutorial(
            key: widget.galleryKey,
            title: "Gallery",
            description:
                "Select an image from your gallery to detect weeds from an existing photo.",
            child: IconButton(
              icon: Icon(Icons.image, color: Colors.white, size: 30),
              onPressed: () async {
                final file = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (file != null) {
                  try {
                    String result = await widget.controller.detectImage(
                      file.path,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ResultPage(result: result, imagePath: file.path),
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
          ),

          /// =========================
          /// CAPTURE
          /// =========================
          CameraTutorial.tutorial(
            key: widget.captureKey,
            title: "Capture",
            description:
                "Tap this button to capture an image. WeedCheck will automatically analyze the captured photo.",
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );

                final file = await widget.controller.takePicture();

                if (context.mounted) Navigator.of(context).pop();

                if (file != null) {
                  try {
                    String result = await widget.controller.detectImage(
                      file.path,
                    );

                    if (context.mounted) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ResultPage(result: result, imagePath: file.path),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Gagal mendeteksi gambar"),
                        ),
                      );
                    }
                  }

                  if (widget.controller.cameraController != null) {
                    widget.controller.cameraController!.startImageStream((
                      image,
                    ) {
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
          ),

          /// =========================
          /// FLIP CAMERA
          /// =========================
          CameraTutorial.tutorial(
            key: widget.flipKey,
            title: "Switch Camera",
            description:
                "Tap this button to switch between the front and rear cameras.",
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: widget.onFlip,
              child: Container(
                width: 55,
                height: 55,
                child: const Icon(Icons.flip_camera_ios, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
