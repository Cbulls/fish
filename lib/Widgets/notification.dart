import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

initNotification() async {
  //안드로이드용 아이콘파일
  var androidSetting = const AndroidInitializationSettings('transparent_fish');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  var iosSetting = const IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);
  await notifications.initialize(
    initializationSettings,
    //알림 누를때 함수실행하고 싶으면
    //onSelectNotification: 함수명추가
  );
}

//2. 이 함수 원하는 곳에서 실행하면 알림 뜸
showNotification() async {
  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 채널 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 100, 190, 241),
  );

  var iosDetails = const IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(1, '제목1', '내용1',
      NotificationDetails(android: androidDetails, iOS: iosDetails));
}
