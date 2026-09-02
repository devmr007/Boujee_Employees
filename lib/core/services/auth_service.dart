import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Storage Keys
  static const String _tokenKey = 'token';
  static const String _tokenFCM = 'token_fcm';
  static const String _userRoleKey = 'userRole';
  static const String _isSetUpKey = 'isSetUp';
  static const String _userIdKey = 'userId';
  static const String _languageKey = 'language';

  static late SharedPreferences _preferences;

  // In-Memory Cached Reference Values
  static String? _token;
  static String? _fcmToken;
  static String? _userRole;
  static bool? _userSetUp;
  static String? _id;
  static String? _language;

  /// Single entry point to initialize preferences and load cached state
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();

    _token = _preferences.getString(_tokenKey);
    _fcmToken = _preferences.getString(_tokenFCM);
    _userRole = _preferences.getString(_userRoleKey);
    _userSetUp = _preferences.getBool(_isSetUpKey);
    _id = _preferences.getString(_userIdKey);
    _language = _preferences.getString(_languageKey);
  }

  // -----------------------------------------------------------------------
  // Checkers
  // -----------------------------------------------------------------------
  static bool hasToken() {
    return _preferences.containsKey(_tokenKey) &&
        _token != null &&
        _token!.isNotEmpty;
  }

  // -----------------------------------------------------------------------
  // Save Methods
  // -----------------------------------------------------------------------
  static Future<void> saveToken(String token) async {
    try {
      await _preferences.setString(_tokenKey, token);
      _token = token;
    } catch (e) {
      log('Error saving token: $e');
    }
  }

  static Future<void> saveFCM(String token) async {
    try {
      await _preferences.setString(_tokenFCM, token);
      _fcmToken = token;
    } catch (e) {
      log('Error saving FCM token: $e');
    }
  }

  static Future<void> saveId(String id) async {
    try {
      await _preferences.setString(_userIdKey, id);
      _id = id;
    } catch (e) {
      log('Error saving user id: $e');
    }
  }

  static Future<void> saveStatus(bool setUp) async {
    try {
      await _preferences.setBool(_isSetUpKey, setUp);
      _userSetUp = setUp;
    } catch (e) {
      log('Error saving onboarding status: $e');
    }
  }

  static Future<void> saveRole(String role) async {
    try {
      await _preferences.setString(_userRoleKey, role);
      _userRole = role;
    } catch (e) {
      log('Error saving user role: $e');
    }
  }

  static Future<void> saveLanguage(String lang) async {
    try {
      await _preferences.setString(_languageKey, lang);
      _language = lang;
    } catch (e) {
      log('Error saving language: $e');
    }
  }

  // -----------------------------------------------------------------------
  // Logout & Cleanup
  // -----------------------------------------------------------------------
  static Future<void> logoutUser() async {
    try {
      await deleteUserData();
      await goToLogin();
    } catch (e) {
      log('Error during user logout sequence: $e');
    }
  }

  /// Clears active user session data while preserving system preferences (e.g. language/FCM)
  static Future<void> deleteUserData() async {
    try {
      await _preferences.remove(_tokenKey);
      await _preferences.remove(_userRoleKey);
      await _preferences.remove(_isSetUpKey);
      await _preferences.remove(_userIdKey);

      // Reset in-memory cached references
      _token = null;
      _userRole = null;
      _userSetUp = null;
      _id = null;
    } catch (e) {
      log('Error clearing user session data: $e');
    }
  }

  static Future<void> goToLogin() async {
    //Get.offAllNamed(AppRoutes.login);
  }

  // -----------------------------------------------------------------------
  // Getters
  // -----------------------------------------------------------------------
  static String? get token => _token;
  static String? get fcmToken => _fcmToken;
  static String? get userRole => _userRole;
  static bool? get userSetUp => _userSetUp;
  static String? get id => _id;
  static String get language => _language ?? "English";
}
