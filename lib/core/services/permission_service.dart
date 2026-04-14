import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestCamera() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> requestGallery() async {
    var status = await Permission.photos.request();
    return status.isGranted;
  }
}