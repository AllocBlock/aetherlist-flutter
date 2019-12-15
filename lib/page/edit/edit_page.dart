import 'dart:convert';

import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/models/category.dart';
import 'package:aetherlist_flutter/models/item.dart';
import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final Item editItem;
  const EditPage({Key key, @required this.editItem}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _titleNameController = TextEditingController();
  TextEditingController _tagsController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  int _selectCategoryId;
  double _priority = 0.5;
  bool _isTimeRangeMode = false;
  bool _enableNotification = false;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _notifyTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _titleNameController.text = widget.editItem.item_name;
    _selectCategoryId = widget.editItem.category_id;
    _priority = widget.editItem.priority;
    _tagsController.text = widget.editItem.tags.join(', ');
    _isTimeRangeMode = widget.editItem.enable_time_range;
    _dueDate = widget.editItem.parseDate();
    _enableNotification = widget.editItem.enable_notification;
    _notifyTime = widget.editItem.parseTime();
    _locationController.text = widget.editItem.location;
    _descriptionController.text = widget.editItem.description;
    print(jsonEncode(widget.editItem));
  }

  @override
  Widget build(BuildContext context) {
    var localeText = CustomLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        titleName: localeText.editItem,
        actionChildren: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: "Delete button",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        localeText.removeItemTip,
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(localeText.cancel),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text(localeText.yes),
                          onPressed: () {
                            Provider.of<AllItemsModel>(context)
                                .removeItem(widget.editItem)
                                .then((result) {
                              if (result) {
                                print("Remove item!");
                                Navigator.pop(context);
                              } else {
                                BotToast.showText(
                                    text: localeText.removeItemErrorText);
                              }
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
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
              newItem.id = widget.editItem.id;
              newItem.item_name = _titleNameController.text;
              newItem.category_id = _selectCategoryId;
              newItem.priority = _priority;
              newItem.tags = _tagsController.text
                  .replaceAll(RegExp(r"\s+\b|\b\s"), "")
                  .split(',');
              newItem.finished = false;
              newItem.enable_time_range = _isTimeRangeMode;
              newItem.due_date = DateFormat("yyyy-MM-dd").format(_dueDate);
              newItem.enable_notification = _enableNotification;
              newItem.notify_time = "${_notifyTime.hour}:${_notifyTime.minute}";
              newItem.location = _locationController.text;
              newItem.description = _descriptionController.text;
              newItem.attachment_list = [];
              Provider.of<AllItemsModel>(context)
                  .editItem(newItem)
                  .then((succeed) {
                BotToast.closeAllLoading();
                print('Json Information: ${jsonEncode(newItem)}');
                if (succeed) {
                  print('Edit item succeed');
                  Navigator.pop(context);
                } else {
                  BotToast.showText(text: localeText.editItemErrorText);
                }
              });
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
                labelText: localeText.itemTitle,
                icon: Icon(
                  Icons.title,
                ),
              ),
              validator: (value) {
                return value.trim().length > 0
                    ? null
                    : localeText.itemTitleValidation;
              },
            ),
            SizedBox(
              height: 12,
            ),
            DropdownButtonFormField(
              validator: (value) {
                return value == null
                    ? localeText.selectCategoryValidation
                    : null;
              },
              value: _selectCategoryId,
              isDense: true,
              items: Provider.of<AllItemsModel>(context)
                  .categories
                  .map<DropdownMenuItem<int>>((Category category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  child: Text(category.category_name),
                );
              }).toList(),
              onChanged: (int newCategoryId) {
                setState(() {
                  _selectCategoryId = newCategoryId;
                });
              },
              decoration: InputDecoration(
                labelText: localeText.category,
                icon: Icon(Icons.category),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(localeText.priority),
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
                labelText: localeText.tags,
                icon: Icon(
                  Icons.turned_in,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ListTile(
              title: Text(localeText.timeRangeMode),
              trailing: Switch(
                value: _isTimeRangeMode,
                onChanged: (value) {
                  setState(() {
                    _isTimeRangeMode = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text(localeText.dueDate),
              subtitle: Text(DateFormat.yMMMMEEEEd().format(_dueDate)),
              trailing: RaisedButton(
                child: const Text('SET'),
                onPressed: () => _selectDate(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ListTile(
              title: Text(localeText.notification),
              trailing: Switch(
                activeColor: Colors.cyan,
                value: _enableNotification,
                onChanged: (value) {
                  setState(() {
                    _enableNotification = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text(localeText.notifyTime),
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
                labelText: localeText.location,
                icon: Icon(
                  Icons.location_on,
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
                labelText: localeText.description,
                icon: Icon(
                  Icons.description,
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
      firstDate: DateTime.now(),
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
