import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseapp/models/brew.dart';
import 'package:flutterfirebaseapp/screens/home/brew_list.dart';
import 'package:flutterfirebaseapp/screens/home/settings_form.dart';
import 'package:flutterfirebaseapp/services/auth.dart';
import 'package:flutterfirebaseapp/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Home', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await _auth.signOut();
              },
                icon: Icon(Icons.person),
                label: Text("Logout")
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings')
            )
          ],
        ),
        body: Container(
          child: BrewList(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
        ),
      )
    );
  }
}
