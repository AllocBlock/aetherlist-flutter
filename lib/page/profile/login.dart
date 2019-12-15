import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/common/request.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/models/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _autoFocusName = true;

  @override
  void initState() {
    _usernameController.text = Global.profile.lastLogin;
    if (_usernameController.text != null) {
      _autoFocusName = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localText = CustomLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
        title: Text(localText.login),
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
                        localText.register,
                        style: TextStyle(color: Colors.cyan[300]),
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                    ),
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
                      child: Text(localText.login),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      elevation: 1.0,
                      onPressed: _onLogin,
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

  void _onLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
      // show loading dialog
      BotToast.showLoading(
        clickClose: false,
        allowClick: false,
        crossPage: false,
      );
      User user;
      try {
        user = await Request.login(
            _usernameController.text, _passwordController.text);
        // homepage will be rebuilt when pop login page, so need not to update
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        // login failed
        if (e.response?.statusCode == 401) {
          BotToast.showText(
              text: CustomLocalizations.of(context).usernameOrPasswordWrong);
        } else {
          BotToast.showText(text: e.toString());
        }
      } finally {
        // pop loading dialog
        BotToast.closeAllLoading();
      }
      if (user != null) {
        print(user.toJson());
        Provider.of<AllItemsModel>(context).fetchCategories();
        Provider.of<AllItemsModel>(context).fetchItems();
        // return to homepage
        Navigator.of(context).pop();
      } else {
        BotToast.showText(
            text: CustomLocalizations.of(context).usernameOrPasswordWrong);
      }
    }
  }
}
