import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String error = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Register'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                validator: (val) =>
                    val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _authService
                        .registerWithEmailPassword(email, password);
                    if (result == null) {
                      setState(() {
                        setState(() {
                          error = "Enter a valid email";
                        });
                      });
                    }
                  }
                },
                child: const Text('Register'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
              TextButton(
                onPressed: () {
                  print('go to signIn');

                  widget.toggleView();
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
