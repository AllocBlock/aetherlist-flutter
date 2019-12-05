import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _titleNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _isTimeRangeMode = false;
  bool _enableNotification = false;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _notifyTime = TimeOfDay.now();

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
          physics: BouncingScrollPhysics(),
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
            SizedBox(height: 10,),
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
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Due date:'),
              subtitle: Text(DateFormat.yMMMMEEEEd().format(_dueDate)),
              trailing: RaisedButton(
                child: const Text('SET'),
                onPressed: () => _selectDate(),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Switch(
                  activeColor: Colors.cyan,
                  value: _enableNotification,
                  onChanged: (value) {
                    setState(() {
                      _enableNotification = value;
                    });
                  },
                ),
                Text('Notification'),
              ],
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Notify time:'),
              subtitle: Text(DateFormat.jm().format(DateTime(2019).add(Duration(hours: _notifyTime.hour, minutes: _notifyTime.minute)))),
              trailing: RaisedButton(
                child: const Text('SET'),
                onPressed: () => _selectTime(),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                icon: Icon(Icons.location_on, color: Colors.grey,),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Description',
                icon: Icon(Icons.description, color: Colors.grey,),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future _selectTime() async {
    TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        },
    );
    if (picked != null) {
      setState(() {
        _notifyTime = picked;
      });
    }
  }
}
