import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class StoragePermissionService {
  final _permissionController = StreamController<PermissionStatus>.broadcast();
  StreamSink<PermissionStatus> get _permissionSink =>
      _permissionController.sink;
  Stream<PermissionStatus> get storagePermission =>
      _permissionController.stream;

  Future<void> requestPermission() async {
    final PermissionStatus permissionStatus = await Permission.storage.status;
    switch (permissionStatus) {
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
        final PermissionStatus requestedStatus =
            await Permission.storage.request();
        if (requestedStatus.isGranted) {
          _permissionSink.add(requestedStatus);
        }
        break;
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      case PermissionStatus.granted:
        _permissionSink.add(permissionStatus);
        break;
    }
  }
}
