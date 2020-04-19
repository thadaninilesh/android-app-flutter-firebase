import 'package:flutter/material.dart';
import 'package:flutterfirebaseapp/services/auth.dart';
import 'package:flutterfirebaseapp/shared/constants.dart';
import 'package:flutterfirebaseapp/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();

}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold (
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign In', style: TextStyle(color: Colors.black.withOpacity(0.6))),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          }, icon: Icon(Icons.person), label: Text('Register', style: TextStyle(color: Colors.black.withOpacity(0.6)),))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
//        alignment: Alignment.topCenter ,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(labelText: 'Email Address'),
                validator: (val) => val.isEmpty ? 'Email Address is empty' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(labelText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.black,
                elevation: 5.0,
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailPassword(email.trim(), password.trim());
                    if (result == null) {
                      setState(() {
                        error = 'Invalid credentials! Please try again';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        )
      ),
    );
  }
}
