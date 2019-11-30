import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _titleNameController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _isTimeRangeMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleName: 'Add new item',
        showSearchIcon: false,
      ),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: ListView(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _titleNameController,
              decoration: InputDecoration(
                labelText: 'Item title',
                icon: Icon(Icons.title, color: Colors.grey,),
              ),
              validator: (value) {
                return value.trim().length > 0 ? null : 'Title cannot be empty';
              },
            ),
            // TODO: add date picker to select due date
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Switch(
                  activeColor: Colors.cyan,
                  value: _isTimeRangeMode,
                  onChanged: (value) {
                    setState(() {
                      _isTimeRangeMode = value;
                    });
                  },
                ),
                Text('Time-range mode'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
