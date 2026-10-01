import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'local_user_id_service.dart';

class NotificationService {
  NotificationService._();

  static const String _oneSignalAppId = '8cb6d50e-0e3d-4908-a9b9-c4aed5d45c58';

  static Future<void> initialize() async {
    OneSignal.initialize(_oneSignalAppId);
    await OneSignal.Notifications.requestPermission(true);

    final localUserId = await LocalUserIdService.getOrCreateId();
    await OneSignal.login(localUserId);
  }
}