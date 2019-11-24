import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
        title: Text('About'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Icon(
                Icons.line_weight,
                size: 100,
              ),
            ),
            Text(
              'AetherList',
              textScaleFactor: 1.5,
              style: TextStyle(height: 1.5),
            ),
            Text(
              'Version: 0.0.1',
              textScaleFactor: 0.75,
              style: TextStyle(color: Colors.grey),
            ),
            Divider(
              height: 40,
            ),
            Text(
              'A flexible todo list.',
              textScaleFactor: 1,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
