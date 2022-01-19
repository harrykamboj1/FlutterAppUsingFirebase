import 'package:firebase_flutter/models/user.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKeys = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  late String _currentName = '';
  late String _currentSugar = "0";
  late int _currentStrength = 100;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKeys,
              child: Column(
                children: [
                  const Text(
                    "Update Your Brew Settings",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                      onChanged: (val) => setState(() {
                        _currentName = val;
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: DropdownButtonFormField(
                      items: sugars.map((String sugar) {
                        return DropdownMenuItem<String>(
                            value: sugar, child: Text('$sugar sugars'));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          this._currentSugar = value!;
                        });
                      },
                      value: _currentSugar ?? userData!.sugars,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Slider(
                        min: 100,
                        activeColor: Colors.brown[_currentStrength ?? 100],
                        inactiveColor: Colors.brown[_currentStrength ?? 100],
                        max: 900,
                        divisions: 8,
                        value:
                            (_currentStrength ?? userData!.strength).toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _currentStrength = value.round();
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink),
                    ),
                    onPressed: () async {
                      if (_formKeys.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugar ?? userData!.sugars,
                            _currentName ?? userData!.name,
                            _currentStrength ?? userData!.strength);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
