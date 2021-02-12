import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show File, Platform;

import 'package:rxdart/subjects.dart';


class NotificationPlugIn {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var initializationSettings;

  Future<void> showNotification() async {
    var androidChanneclSpecifies = AndroidNotificationDetails(
      "CHANNEL_ID",
      "CHANNEL_NAME",
      "CHANNEL_DESCRIPTION",
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
// androidChanneclSpecifies, iOS: iosChannelSpecifics);
    var platformChannelSpecifics =
        NotificationDetails(androidChanneclSpecifies, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Test Title', 'Test Body', platformChannelSpecifics,
        payload: 'TeST Payload');
  }

  NotificationPlugIn._() {
    init();
  }

  Future<void> scheduleNotification() async {
    var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 5));

    var androidChanneclSpecifies = AndroidNotificationDetails(
      "CHANNEL_ID 1",
      "CHANNEL_NAME 1",
      "CHANNEL_DESCRIPTION 1",
      icon: 'seconday_icon',
      sound: RawResourceAndroidNotificationSound('my_sound'),
      largeIcon: DrawableResourceAndroidBitmap('large_notf_icon'),
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iosChannelSpecifics = IOSNotificationDetails(
      sound: 'my_sound.aiff',
    );
//     var platformChannelSpecifics = NotificationDetails(
// androidChanneclSpecifies, iOS: iosChannelSpecifics);
    var platformChannelSpecifics =
        NotificationDetails(androidChanneclSpecifies, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(0, 'Test Tiiitle',
        'Test Body', scheduleNotificationDateTime, platformChannelSpecifics,
        payload: 'TeST Payload');
  }

  // Future<void> showNotificationWithAttachment() async {
  //   var attachmentPicturePath = await _downloadAndSaveFile(
  //       'https://via.placeholder.com/350x150', 'attachment_img_jpg');
  //   var iOSPlatformSpecifics = IOSNotificationDetails(
  //       attachments: [IOSNotificationAttachment(attachmentPicturePath)]);
  //   var bigPictureStyleInformation = BigPictureStyleInformation(
  //     FilePathAndroidBitmap(attachmentPicturePath),
  //     contentTitle: '<b>Attached Image</b>',
  //     htmlFormatContentTitle: true,
  //     summaryText: 'TextImage',
  //     htmlFormatSummaryText: true,
  //   );
  //   var androidChannelSpecifics = AndroidNotificationDetails(
  //       "CHANNEL ID 2", "CHANNEL NAME 2", "CHANNEL DESCRIPTION 2",
  //       importance: Importance.High,
  //       priority: Priority.High,
  //       styleInformation: bigPictureStyleInformation);
  //   var notificationDetails = NotificationDetails(androidChannelSpecifics,iOSPlatformSpecifics);
  //   await flutterLocalNotificationsPlugin.show(0, 'Title with attachment', "Body With attachment", notificationDetails);
  //   print('abc');
  // }
  //
  // _downloadAndSaveFile(String url, String fileName) async {
  //   var directory = await getApplicationDocumentsDirectory();
  //   var filePath = '${directory.path}/$fileName';
  //   var response = await http.get(url);
  //   var file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   return filePath;
  // }
  Future<void> repeatNotification() async {
    var androidChanneclSpecifies = AndroidNotificationDetails(
      "CHANNEL_ID 3",
      "CHANNEL_NAME 3",
      "CHANNEL_DESCRIPTION 3",
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
// androidChanneclSpecifies, iOS: iosChannelSpecifics);
    var platformChannelSpecifics =
    NotificationDetails(androidChanneclSpecifies, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0, 'Test Title', 'Test Body',
        RepeatInterval.EveryMinute,
        platformChannelSpecifics,
        payload: 'TeST Payload');
  }

  Future<void> showDailyAtTIme() async {
    var time = Time(14,56,0);
    var androidChanneclSpecifies = AndroidNotificationDetails(
      "CHANNEL_ID 4",
      "CHANNEL_NAME 4",
      "CHANNEL_DESCRIPTION 4",
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
    );

    var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
// androidChanneclSpecifies, iOS: iosChannelSpecifics);
    var platformChannelSpecifics =
    NotificationDetails(androidChanneclSpecifies, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0, 'Test Title', 'Test Body',
        time,
        platformChannelSpecifics,
        payload: 'TeST Payload');
  }

  Future<void> showWeeklyAtTime() async {
    var time = Time(15,14,0);
    var androidChanneclSpecifies = AndroidNotificationDetails(
      "CHANNEL_ID 5",
      "CHANNEL_NAME 5",
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
    );

    var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
// androidChanneclSpecifies, iOS: iosChannelSpecifics);
    var platformChannelSpecifics =
    NotificationDetails(androidChanneclSpecifies, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0, 'Test Title', 'Test Body',
        Day.Thursday,
        time,
        platformChannelSpecifics,
        payload: 'TeST Payload');
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings("app_notf_icon");
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceivedNotification receivedNotification = ReceivedNotification(
              id: id, title: title, body: body, payload: payload);
          didReceivedLocalNotificationSubject.add(receivedNotification);
        });
    //   initializationSettings = InitializationSettings(
    //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // }
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen(
      (receivedNotification) {
        onNotificationInLowerVersions(receivedNotification);
      },
    );
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }
  Future<int> getPendingNotificationCount() async{
    List<PendingNotificationRequest> p =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return p.length;
  }
  Future<void> cancelNotification() async{
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}



NotificationPlugIn notificationPlugIn = NotificationPlugIn._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}




