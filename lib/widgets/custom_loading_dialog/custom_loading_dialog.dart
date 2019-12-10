import 'package:flutter/material.dart';

class CustomLoadingDialog extends StatefulWidget {
  final Widget loading;
  const CustomLoadingDialog({Key key, this.loading}) : super(key: key);

  @override
  _CustomLoadingDialogState createState() => _CustomLoadingDialogState();
}

class _CustomLoadingDialogState extends State<CustomLoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: 50, height: 50, child: CircularProgressIndicator()),
          SizedBox(
            height: 10,
          ),
          widget.loading,
        ],
      ),
    );
  }
}
