import 'dart:math';

import 'package:dictionary_app/saved_word_screen.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isOn = false;
  bool isVal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings & Privacy',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 90),
              Text(
                "General",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(color: Colors.black26, thickness: 0.88),
              SizedBox(height: 24),
              ListTile(
                leading: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.black54,
                ),
                contentPadding: EdgeInsets.zero,

                title: Text(
                  'Account',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.black54,
                ),
                contentPadding: EdgeInsets.zero,

                title: Text(
                  'Notifications',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                trailing: Transform.scale(
                  scale: 0.76,
                  child: Switch(
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    value: isOn,
                    onChanged: (value) {
                      setState(() {
                        isOn = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.wifi, color: Colors.black54),
                contentPadding: EdgeInsets.zero,

                title: Text(
                  'WI-FI',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                trailing: Transform.scale(
                  scale: 0.76,
                  child: Switch(
                    padding: EdgeInsets.zero,

                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    value: isVal,
                    onChanged: (value) {
                      setState(() {
                        isVal = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SavedWordsScreen();
                      },
                    ),
                  );
                },
                leading: Icon(
                  Icons.bookmark_outline_rounded,
                  color: Colors.black54,
                ),

                title: Text(
                  'Bookmarks &  Saved',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ),
              SizedBox(height: 90),
              Text(
                "General",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(color: Colors.black26, thickness: 0.88),

              SizedBox(height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,

                leading: Icon(
                  Icons.error_outline_outlined,
                  color: Colors.black54,
                ),

                title: Text(
                  'Report a problem',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ),
              SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SavedWordsScreen();
                      },
                    ),
                  );
                },
                leading: Icon(Icons.send_outlined, color: Colors.black54),

                title: Text(
                  'Send Feedback',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
