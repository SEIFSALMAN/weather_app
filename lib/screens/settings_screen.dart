import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/weather_model.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  int notificationFrequency = 1; // 0 for Never, 1 for Daily, 2 for Weekly
  bool darkModeEnabled = false;
  Color selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff060720),
      appBar: AppBar(
        backgroundColor: Color(0xff060720),
        title: Text('Settings',style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          SwitchListTile(
            title: Text('Enable Notifications',style: TextStyle(color: Colors.white),),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
          ListTile(
            title: Text('Notification Frequency',style: TextStyle(color: Colors.white),),
            subtitle: Text(_getNotificationFrequencyText(),style: TextStyle(color: Colors.white.withOpacity(0.7))),
            onTap: () {
              _showFrequencyDialog(context);
            },
          ),
          SwitchListTile(
            title: Text('Dark Mode',style: TextStyle(color: Colors.white),),
            value: darkModeEnabled,
            onChanged: (value) {
              setState(() {
                darkModeEnabled = value;
              });
            },
          ),
          ListTile(
            title: Text('Theme Color',style: TextStyle(color: Colors.white),),
            subtitle: Text(selectedColor == Colors.blue ? 'Blue' : 'Red',style: TextStyle(color: Colors.white.withOpacity(0.7))), // Display the selected color
            onTap: () {
              _showColorDialog(context);
            },
          ),
          ListTile(
            title: Text('Login',style: TextStyle(color: Colors.white),),
            onTap: () {
              // Implement your login functionality here
            },
          ),
          ListTile(
            title: Text('Rate Us',style: TextStyle(color: Colors.white),),
            onTap: () {
              // Implement your rate us functionality here
            },
          ),
        ],
      ),
    );
  }

  String _getNotificationFrequencyText() {
    switch (notificationFrequency) {
      case 0:
        return 'Never';
      case 1:
        return 'Daily';
      case 2:
        return 'Weekly';
      default:
        return '';
    }
  }

  void _showFrequencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xff060720),
        title: Text('Notification Frequency',style: TextStyle(color: Colors.white.withOpacity(0.7))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<int>(
              title: Text('Never',style: TextStyle(color: Colors.white)),
              value: 0,
              groupValue: notificationFrequency,
              onChanged: (value) {
                setState(() {
                  notificationFrequency = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<int>(
              title: Text('Daily',style: TextStyle(color: Colors.white)),
              value: 1,
              groupValue: notificationFrequency,
              onChanged: (value) {
                setState(() {
                  notificationFrequency = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<int>(
              title: Text('Weekly',style: TextStyle(color: Colors.white)),
              value: 2,
              groupValue: notificationFrequency,
              onChanged: (value) {
                setState(() {
                  notificationFrequency = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showColorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xff060720),
        title: Text('Select Theme Color',style: TextStyle(color: Colors.white),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<Color>(
              title: Text('Blue',style: TextStyle(color: Colors.white.withOpacity(0.7))),
              value: Colors.blue,
              groupValue: selectedColor,
              onChanged: (value) {
                setState(() {
                  selectedColor = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<Color>(
              title: Text('Red',style: TextStyle(color: Colors.white.withOpacity(0.7))),
              value: Colors.red,
              groupValue: selectedColor,
              onChanged: (value) {
                setState(() {
                  selectedColor = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
