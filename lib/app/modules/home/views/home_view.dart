import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../service/notification_service.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body:  Center(
        child: IconButton(
            onPressed: () async {


              final token = 'f8T9rAGwRVCXAGU8U8kVDy:APA91bH2-KBehKXnYoCegoHvCN1Eb1PCXSjQgvstfAanzwvDHjINjaHQFblRjHKtAtC_wFxhumv8qwC6XQ5sRfeCKLbSdjMaCXjryikx6uzH7YnSARfClVJZFFm-BWD6BDEDLknGxQWd';

              final accessToken = await NotificationService().getAccessToken();
              print('This is token in -${token}');

              // Step 3: Send notification and store it in Firestore
              bool notificationSent = await NotificationService().sendNotification(
                  accessToken, token, 'inputText', 'Your child has been ${'inputText'}');


        }, icon: Icon(Icons.send))
      ),
    );
  }
}
