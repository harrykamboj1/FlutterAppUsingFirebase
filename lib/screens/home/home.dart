import 'package:firebase_flutter/models/brew.dart';
import 'package:firebase_flutter/screens/authenticate/authenticate.dart';
import 'package:firebase_flutter/screens/home/brewlist.dart';
import 'package:firebase_flutter/screens/home/settings_form.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingForm();
          });
    }

    final AuthService _auth = AuthService();

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[500],
          title: const Text('Brew brew'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.keyboard_return),
              tooltip: 'Sign OUt',
              onPressed: () async {
                // handle the press
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              label: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showSettingPanel();
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
