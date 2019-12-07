import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// FOR TEST ONLY
const List<String> _testCategories = ["Academic", "Shopping", "Health"];

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _titleNameController = TextEditingController();
  TextEditingController _tagsController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  String _selectCategory = _testCategories[0];
  double _priority = 0.5;
  bool _isTimeRangeMode = false;
  bool _enableNotification = false;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _notifyTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleName: 'Add new item',
        actionChildren: <Widget>[],
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
                icon: Icon(
                  Icons.title,
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                return value.trim().length > 0 ? null : 'Title cannot be empty';
              },
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Category'),
                SizedBox(width: 15,),
                DropdownButton(
                  value: _selectCategory,
                  items: _testCategories.map<DropdownMenuItem<String>>((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category, textScaleFactor: 0.85,),
                    );
                  }).toList(),
                  onChanged: (String newCategory) {
                    setState(() {
                      _selectCategory = newCategory;
                    });
                  },
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Priority'),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.amber[300],
                      inactiveTrackColor: Colors.blue[100],
                      trackHeight: 4.0,
                      thumbColor: Colors.red,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 8.0),
                      overlayColor: Colors.purple.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 14.0),
                    ),
                    child: Slider(
                      min: 0.01,
                      max: 0.99,
                      value: _priority,
                      onChanged: (newValue) {
                        setState(() {
                          _priority = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            TextFormField(
              controller: _tagsController,
              decoration: InputDecoration(
                labelText: 'Tags',
                icon: Icon(
                  Icons.turned_in,
                  color: Colors.grey,
                ),
              ),
            ),
            Divider(),
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
                Text(
                  'Time-range mode',
                  textScaleFactor: 1.2,
                ),
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text('Due date:'),
              subtitle: Text(DateFormat.yMMMMEEEEd().format(_dueDate)),
              trailing: RaisedButton(
                child: const Text('SET'),
                onPressed: () => _selectDate(),
              ),
            ),
            Divider(),
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
                Text(
                  'Notification',
                  textScaleFactor: 1.2,
                ),
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Notify time:'),
              subtitle: Text(DateFormat.jm().format(DateTime(2019).add(Duration(
                  hours: _notifyTime.hour, minutes: _notifyTime.minute)))),
              trailing: RaisedButton(
                child: const Text('SET'),
                onPressed: () => _selectTime(),
              ),
            ),
            Divider(),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                icon: Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
              ),
            ),
            Divider(),
            TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Description',
                icon: Icon(
                  Icons.description,
                  color: Colors.grey,
                ),
              ),
            ),
            Divider(),
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
    );
    if (picked != null) {
      setState(() {
        _notifyTime = picked;
      });
    }
  }
}
