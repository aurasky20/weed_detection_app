import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../controllers/camera_controller.dart';

class CameraView extends StatefulWidget {
  final CameraControllerX controller;
  const CameraView({required this.controller});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  double _zoom = 1.0;
  double _baseZoom = 1.0;

  @override
  void dispose() {
    widget.controller.cameraController?.stopImageStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final cam = widget.controller.cameraController;

        // Loading state
        if (cam == null || !cam.value.isInitialized) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    "Memuat kamera...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }

        return Stack(
          children: [
            // Camera preview
            GestureDetector(
              onScaleStart: (_) => _baseZoom = _zoom,
              onScaleUpdate: (details) async {
                double zoom = (_baseZoom * details.scale).clamp(
                  widget.controller.minZoom,
                  widget.controller.maxZoom,
                );
                _zoom = zoom;
                await widget.controller.setZoom(zoom);
              },
              child: ClipRect(
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: cam.value.previewSize!.height,
                      height: cam.value.previewSize!.width,
                      child: CameraPreview(cam),
                    ),
                  ),
                ),
              ),
            ),

            /// 🌿 GUIDE FRAME (arahkan kamera ke gulma)
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                child: Stack(
                  children: [
                    // Sudut kiri atas
                    Positioned(
                      top: 0,
                      left: 0,
                      child: _CornerBracket(alignment: Alignment.topLeft),
                    ),
                    // Sudut kanan atas
                    Positioned(
                      top: 0,
                      right: 0,
                      child: _CornerBracket(alignment: Alignment.topRight),
                    ),
                    // Sudut kiri bawah
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: _CornerBracket(alignment: Alignment.bottomLeft),
                    ),
                    // Sudut kanan bawah
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _CornerBracket(alignment: Alignment.bottomRight),
                    ),

                    // Ikon & teks panduan di tengah
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.eco_outlined,
                            color: Colors.white.withOpacity(0.4),
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Ambil gambar Gulma",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 🌞 BRIGHTNESS
            Positioned(
              right: 8,
              top: 100,
              bottom: 100,
              child: Column(
                children: [
                  Icon(Icons.wb_sunny, color: Colors.orange),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(
                            0xFFFFC107,
                          ), // Amber 500
                          inactiveTrackColor: Colors.white24,
                          thumbColor: const Color(0xFFFFC107),
                          overlayColor: const Color(0x33FFC107),
                          trackHeight: 3,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8,
                          ),
                        ),
                        child: Slider(
                          value: widget.controller.currentExposure,
                          min: widget.controller.minExposure,
                          max: widget.controller.maxExposure,
                          onChanged: (value) async {
                            await widget.controller.setExposure(value);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.nightlight_round, color: Colors.orange),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Widget kecil untuk menggambar sudut bingkai tipis (bracket corner)
class _CornerBracket extends StatelessWidget {
  final Alignment alignment;
  final double size;
  final double thickness;
  final Color color;

  const _CornerBracket({
    required this.alignment,
    this.size = 28,
    this.thickness = 2.5,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: color.withOpacity(0.5),
      width: thickness,
    );

    Border border;
    if (alignment == Alignment.topLeft) {
      border = Border(top: borderSide, left: borderSide);
    } else if (alignment == Alignment.topRight) {
      border = Border(top: borderSide, right: borderSide);
    } else if (alignment == Alignment.bottomLeft) {
      border = Border(bottom: borderSide, left: borderSide);
    } else {
      border = Border(bottom: borderSide, right: borderSide);
    }

    return Container(width: size, height: size, decoration: BoxDecoration(border: border));
  }
}