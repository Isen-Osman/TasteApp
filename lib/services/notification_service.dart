import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/meal.dart';
import 'api_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class NotificationsService {
  //IOS
  static Future<void> init() async {
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onReceiveLocalNotification,
    );

    const settings = InitializationSettings(iOS: iosSettings);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  static Future<void> scheduleDailyRecipe() async {
    tz.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      16, // cas
      20, // minuti
    );

    Meal meal = await ApiService.getRandomMeal();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Рецепт на денот',
      meal.name,
      scheduledTime.isBefore(now) ? scheduledTime.add(Duration(days: 1)) : scheduledTime,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          sound: 'default',
          badgeNumber: 1,
          subtitle: 'Нов рецепт за денес!',
          threadIdentifier: 'daily_recipe_thread',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // Callback за iOS
  static void _onReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    print('iOS нотификација: $title - $body');
  }

  static void _onNotificationResponse(NotificationResponse response) {
    print('Клик на нотификација: ${response.payload}');
  }
}
