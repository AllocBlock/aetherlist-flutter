import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/models/category.dart';
import 'package:aetherlist_flutter/models/item.dart';
import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  Category _selectCategory;
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
        actionChildren: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: "Save button",
            onPressed: () {
              BotToast.showLoading(
                clickClose: false,
                allowClick: false,
                crossPage: false,
              );
              Item newItem = Item();
              newItem.id = 0;
              newItem.item_name = _titleNameController.text;
              newItem.category_id = _selectCategory.id;
              newItem.priority = _priority;
              newItem.tags = _tagsController.text.split(',');
              newItem.enable_time_range = _isTimeRangeMode;
              newItem.due_date = DateFormat("yyyy-MM-dd").format(_dueDate);
              newItem.enable_notification = _enableNotification;
              newItem.notify_time = "${_notifyTime.hour}:${_notifyTime.minute}";
              newItem.location = _locationController.text;
              newItem.description = _descriptionController.text;
              Provider.of<AllItemsModel>(context)
                  .addItem(newItem)
                  .then((succeed) {
                BotToast.closeAllLoading();
                if (succeed) {
                } else {}
              });
              Navigator.pop(context);
            },
          ),
        ],
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
            SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Category'),
                SizedBox(
                  width: 15,
                ),
                DropdownButton(
                  value: _selectCategory,
                  items: Provider.of<AllItemsModel>(context)
                      .categories
                      .map<DropdownMenuItem<Category>>((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(
                        category.category_name,
                        textScaleFactor: 0.85,
                      ),
                    );
                  }).toList(),
                  onChanged: (Category newCategory) {
                    setState(() {
                      _selectCategory = newCategory;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
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
            SizedBox(
              height: 12,
            ),
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
            SizedBox(
              height: 12,
            ),
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
            SizedBox(
              height: 12,
            ),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text('Due date:'),
              subtitle: Text(DateFormat.yMMMMEEEEd().format(_dueDate)),
              trailing: RaisedButton(
                child: const Text('SET'),
                onPressed: () => _selectDate(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
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
            SizedBox(
              height: 12,
            ),
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
            SizedBox(
              height: 12,
            ),
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
            SizedBox(
              height: 12,
            ),
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
            SizedBox(
              height: 12,
            ),
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
