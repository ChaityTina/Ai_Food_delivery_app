import 'package:flutter/material.dart';
import '../screens/selectlanguage.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return settingsPage();
  }
}

class settingsPage extends State<settings> {
  bool pushNotification = false;
  bool locationEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Profile',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('Push Notification'),
            trailing: Switch(
              value: pushNotification,
              activeColor: Colors.orange,
              onChanged: (val) {
                setState(() {
                  pushNotification = val;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Location'),
            trailing: Switch(
              value: locationEnabled,
              activeColor: Colors.orange,
              onChanged: (val) {
                setState(() {
                  locationEnabled = val;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Language'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('English', style: TextStyle(fontSize: 15)),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 20),
              ],
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return selectlanguage();
                },
              );
            },
          ),
          SizedBox(height: 24),

          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Other',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('About Ticketis'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            title: Text('Terms and Conditions'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
