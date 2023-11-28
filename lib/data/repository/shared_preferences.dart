import 'package:saturn/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  Future<void> saveUserId(int userId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', userId);
    } catch (e, stackTrace) {
      logger.e('Error saving user ID: $e, stackTrace $stackTrace');
      throw Exception('Error saving user ID: $e, stackTrace $stackTrace');
    }
  }

  Future<int?> getUserId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('userId');
      return userId;
    } catch (e, stackTrace) {
      logger.e('Error getting user ID: $e, stackTrace $stackTrace');
      throw Exception('Error getting user ID: $e, stackTrace $stackTrace');
    }
  }

  Future<void> removeUserId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      await prefs.clear();
    } catch (e, stackTrace) {
      logger.e('Error in removeUserId: $e, stackTrace $stackTrace');
      throw Exception('Error in removeUserId: $e, stackTrace $stackTrace');
    }
  }

  Future<bool> checkUserId() async {
    try {
      final int? userId = await getUserId();
      if (userId != null) {
        return true;
      } else {
        return false;
      }
    } catch (error, stackTrace) {
      logger.e(
          'Error occurred while fetching user ID: $error, stackTrace $stackTrace');
      throw Exception(
          'Error occurred while fetching user ID: $error, stackTrace $stackTrace');
    }
  }

  Future<void> saveUserData(String username, String email) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('userData', <String>[username, email]);
      logger.i('User data saved successfully.');
    } catch (e, stackTrace) {
      logger.e('Error saving user data: $e, stackTrace $stackTrace');
      throw Exception('Error saving user data: $e, stackTrace $stackTrace');
    }
  }

  Future<List<String>?> getUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? userData = prefs.getStringList('userData');
      return userData;
    } catch (e, stackTrace) {
      logger.e('Error retrieving user data: $e, stackTrace $stackTrace');
      throw Exception('Error retrieving user data: $e, stackTrace $stackTrace');
    }
  }

  Future<void> removeUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userData');
      await prefs.clear();
    } catch (e, stackTrace) {
      logger.e('Error removing user data: $e, stackTrace $stackTrace');
      throw Exception('Error removing user data: $e, stackTrace $stackTrace');
    }
  }
}
