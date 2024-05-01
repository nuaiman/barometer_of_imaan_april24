import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/initialization/views/initialization_view.dart';
import 'features/reminder/controllers/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarIconBrightness: Brightness.dark,
  ));
  await AwesomeNotifications().initialize(
    // 'resource://drawable/launch_background',
    null,
    [
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '0',
        channelName: 'Sunrise',
        channelDescription: 'Sunrise',
        soundSource: 'resource://raw/alert',
      ),
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '00',
        channelName: 'Sunrise',
        channelDescription: 'Sunrise',
        soundSource: 'resource://raw/azan',
      ),
      // -----------------------------------------------------------------------
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '1',
        channelName: 'Fazr',
        channelDescription: 'Fazr',
        soundSource: 'resource://raw/alert',
      ),
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '10',
        channelName: 'Fazr',
        channelDescription: 'Fazr',
        soundSource: 'resource://raw/azan',
      ),
      // -----------------------------------------------------------------------
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '2',
        channelName: 'Dhuhr',
        channelDescription: 'Dhuhr',
        soundSource: 'resource://raw/alert',
      ),
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '20',
        channelName: 'Dhuhr',
        channelDescription: 'Dhuhr',
        soundSource: 'resource://raw/azan',
      ),
      // -----------------------------------------------------------------------
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '3',
        channelName: 'Asr',
        channelDescription: 'Asr',
        soundSource: 'resource://raw/alert',
      ),
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '30',
        channelName: 'Asr',
        channelDescription: 'Asr',
        soundSource: 'resource://raw/azan',
      ),
      // -----------------------------------------------------------------------
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '4',
        channelName: 'Magrib',
        channelDescription: 'Magrib',
        soundSource: 'resource://raw/alert',
      ),
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '40',
        channelName: 'Magrib',
        channelDescription: 'Magrib',
        soundSource: 'resource://raw/azan',
      ),
      // -----------------------------------------------------------------------
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '5',
        channelName: 'Isha',
        channelDescription: 'Isha',
        soundSource: 'resource://raw/alert',
      ),
      NotificationChannel(
        criticalAlerts: true,
        importance: NotificationImportance.High,
        channelGroupKey: 'Salah',
        channelKey: '50',
        channelName: 'Isha',
        channelDescription: 'Isha',
        soundSource: 'resource://raw/azan',
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'Salah',
        channelGroupName: 'Salah Channel',
      ),
    ],
  );
  bool isNotificationsAllowed =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isNotificationsAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
    main();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationActionServices.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationActionServices.onNotificationCreatedMethod,
      onDismissActionReceivedMethod:
          NotificationActionServices.onActionReceivedMethod,
      onNotificationDisplayedMethod:
          NotificationActionServices.onNotificationDisplayedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Tasheel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        cardTheme: const CardTheme(
          color: Color(0xFFEFEFEF),
          surfaceTintColor: Color(0xFFEFEFEF),
        ),
      ),
      home: const InitializationView(),
    );
  }
}
