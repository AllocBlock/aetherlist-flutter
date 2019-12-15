import 'package:aetherlist_flutter/common/request.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _autoFocusName = true;

  @override
  Widget build(BuildContext context) {
    var localText = CustomLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
        title: Text(localText.register),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          children: <Widget>[
            const SizedBox(height: 32.0),
            Column(
              children: <Widget>[
                Icon(
                  Icons.line_weight,
                  size: 64,
                ),
                const SizedBox(height: 32.0),
                Text(
                  'AetherList',
                  textScaleFactor: 1.75,
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: _autoFocusName,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: localText.username,
                    ),
                    validator: (v) {
                      return v.trim().isNotEmpty
                          ? null
                          : localText.usernameRequired;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    autofocus: !_autoFocusName,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: localText.password,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: !showPassword,
                    validator: (v) {
                      return v.trim().isNotEmpty
                          ? null
                          : localText.passwordRequired;
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Wrap(
              children: <Widget>[
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        localText.cancel,
                        style: TextStyle(color: Colors.grey),
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text(localText.register),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      elevation: 1.0,
                      onPressed: _onRegister,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onRegister() async {
    if ((_formKey.currentState as FormState).validate()) {
      // show loading dialog
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    width: 50, height: 50, child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      );
      bool succeed;
      try {
        succeed = await Request.register(
            _usernameController.text, _passwordController.text);
      } catch (e) {
        // register failed
        BotToast.showText(text: e.toString());
      } finally {
        // pop loading dialog
        Navigator.of(context).pop();
      }
      if (succeed) {
        // return to login page
        Navigator.of(context).pop();
      } else {
        BotToast.showText(text: "register failed");
      }
    }
  }
}
