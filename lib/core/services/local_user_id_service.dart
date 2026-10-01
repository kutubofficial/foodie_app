import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Generates and persists a per-install pseudo-user ID, with no backend
/// involved. This exists purely so OneSignal has a stable identity to
/// target via OneSignal.login() — in a real production app with real
/// accounts, this would be replaced by your actual backend's user ID
/// (e.g. whatever Firebase Auth or your own auth system assigns).
class LocalUserIdService {
  LocalUserIdService._();

  static const _prefsKey = 'foodie_local_user_id';

  /// Returns the existing local user ID if one was already generated,
  /// or creates and saves a new one on first app launch.
  static Future<String> getOrCreateId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_prefsKey);
    if (existing != null) return existing;

    final newId = const Uuid().v4();
    await prefs.setString(_prefsKey, newId);
    return newId;
  }
}