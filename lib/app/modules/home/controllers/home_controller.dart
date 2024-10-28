import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {


  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  RxString FCMToken=''.obs;


  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {

          //Get.to(() => NotificationPage());


        }
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }





  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    _initializeNotifications();


    messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      criticalAlert: true,
    ).then((NotificationSettings settings) async {
      // Check the permission status and call submitData if allowed
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        String? deviceToken = await messaging.getToken();
        FCMToken.value=deviceToken!;
        debugPrint(
            '**********************Notification Token*************${deviceToken}**************************');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.notification?.title}');
      _showNotification(
        message.notification?.title,
        message.notification?.body,
        message.data,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked! Opened app from background or terminated.');
      _navigateToDetails(message);
    });

    _checkForInitialMessage();




  }


  Future<void> _checkForInitialMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _navigateToDetails(initialMessage);
    }
  }


  void _navigateToDetails(RemoteMessage message) {
    Get.toNamed(Routes.NOTIFICATION_PAGE);

  }



  Future<void> _showNotification(
      String? title, String? body, Map<String, dynamic> data) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: body,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
