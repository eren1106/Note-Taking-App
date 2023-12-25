import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/text_styles.dart';
import 'package:note_taking_app/utils/notification_service.dart';
import 'package:note_taking_app/view/widgets/gap.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isDarkMode = false;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }

    await NotificationService.showNotification(
      title: "Title of the notification",
      body: "Body of the notification",
      summary: "Small Summary",
      notificationLayout: NotificationLayout.Inbox,
    );
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: "Settings",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Reminder Time:",
                style: KTextStyle.n16,
              ),
              const Gap(x: 12),
              ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: Text(_selectedTime.format(context)),
              ),
            ],
          ),
          const Gap(y: 12),
          Row(
            children: [
              const Text(
                "Dark Mode:",
                style: KTextStyle.n16,
              ),
              Switch(
                value: _isDarkMode,
                onChanged: (bool newValue) {
                  _toggleTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
