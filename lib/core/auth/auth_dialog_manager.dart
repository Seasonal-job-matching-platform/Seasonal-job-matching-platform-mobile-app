import '../logger.dart';

class AuthDialogManager {
  static final AuthDialogManager _instance = AuthDialogManager._internal();
  factory AuthDialogManager() => _instance;
  AuthDialogManager._internal();

  bool _isSessionExpiredHandled = false;
  bool get isSessionExpiredHandled => _isSessionExpiredHandled;

  void markSessionExpiredHandled() {
    _isSessionExpiredHandled = true;
    AppLogger.debug('[DEBUG] AuthDialogManager: Session expired marked as handled');
  }

  void resetSessionExpired() {
    _isSessionExpiredHandled = false;
    AppLogger.debug('[DEBUG] AuthDialogManager: Session expired flag reset');
  }
}
