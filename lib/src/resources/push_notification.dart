import 'package:cartech_app/src/resources/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const USER_TOPIC_NAME = 'user';

class PushNotificationsManager {
  // Private constructor
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static bool _initialized = false;

  static Future<void> init(Function(Map<String, dynamic> message) onMessage) async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.subscribeToTopic(USER_TOPIC_NAME);

      _firebaseMessaging.configure(
        // Foreground
          onMessage: (Map<String, dynamic> message) async {
            onMessage(message);
            print("onMessage" + message.toString());
          },
          // Background
          onResume: (Map<String, dynamic> message) async {},
          // App has been terminated and it needs to reboot
          onLaunch: (Map<String, dynamic> message) async {});

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;

      Utils.saveFCMToken(token);
    }
  }

  static setOnMessage(Function onMessage){
    _firebaseMessaging.configure(
      // Foreground
        onMessage: (Map<String, dynamic> message) async {
          onMessage(message);
          print("onMessage" + message.toString());
        },
        // Background
        onResume: (Map<String, dynamic> message) async {},
        // App has been terminated and it needs to reboot
        onLaunch: (Map<String, dynamic> message) async {});
  }

  static Future<String> getoken() async {
    final token = await _firebaseMessaging.getToken();
    return token;
  }
}