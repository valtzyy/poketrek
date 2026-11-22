// MODUL VII - Local Notification (immediate & scheduled), sama seperti di modul
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Inisialisasi timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    // Inisialisasi implementasi Android secara eksplisit untuk mencegah error LateInitializationError
    if (Platform.isAndroid) {
      AndroidFlutterLocalNotificationsPlugin.registerWith();
    }

    // Konfigurasi Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );
    await notificationsPlugin.initialize(settings: initSettings);

    // Permission
    final androidPlatform = notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlatform?.requestNotificationsPermission();

    // Bikin Channel untuk Reminder
    const AndroidNotificationChannel reminderChannel = AndroidNotificationChannel(
      'reminder_channel',
      'Reminder Notification',
      description: 'Channel untuk reminder notifikasi',
      importance: Importance.high,
    );
    await androidPlatform?.createNotificationChannel(reminderChannel);

    // Bikin Channel untuk Notifikasi Instan
    const AndroidNotificationChannel instantChannel = AndroidNotificationChannel(
      'notif_instan',
      'Notifikasi Instan',
      description: 'Channel untuk notifikasi instan',
      importance: Importance.high,
    );
    await androidPlatform?.createNotificationChannel(instantChannel);
  }

  Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'notif_instan',
          'Notifikasi Instan',
          channelDescription: 'Channel untuk notifikasi instan',
          importance: Importance.high,
          priority: Priority.high,
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }

  // Scheduled notification: muncul di waktu yang ditentukan
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'reminder_channel',
          'Reminder Notification',
          importance: Importance.high,
          priority: Priority.high,
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      // Buat TZDateTime langsung dari komponen waktu agar tidak ada
      // kesalahan konversi timezone
      scheduledDate: tz.TZDateTime(
        tz.local,
        scheduledTime.year,
        scheduledTime.month,
        scheduledTime.day,
        scheduledTime.hour,
        scheduledTime.minute,
      ),
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
