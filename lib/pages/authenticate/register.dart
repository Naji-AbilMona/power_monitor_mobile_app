import 'package:flutter/material.dart';
import 'package:power_monitor/services/auth.dart';
import 'package:power_monitor/shared/constants.dart';
import 'package:power_monitor/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.blue[800],
            appBar: AppBar(
              backgroundColor: Colors.blue[600],
              elevation: 0.0,
              title: Text('Sign up to power monitor'),
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Sign in'),
                    onPressed: () {
                      widget.toggleView();
                    })
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) =>
                            val.length < 6 ? 'Enter a password, 6 or more characters' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.green[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'please input a valid email';
                                loading = false;
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    Image(
                      image: AssetImage('assets/PowerMonitorLogo.jpg'),
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
