import 'package:firebase_flutter/screens/authenticate/register.dart';
import 'package:firebase_flutter/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      print('show Sign In');
      return SignIn(toggleView: toggleView);
    } else {
      print('show Register');
      return Register(toggleView: toggleView);
    }
  }
}
