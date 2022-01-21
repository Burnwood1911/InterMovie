import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_movie/screens/home.dart';
import 'package:inter_movie/services/api_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  ApiService? _apiService;
  bool isLoging = false;

  signIn() async {
    
    if (_formKey.currentState!.validate()) {
      setState(() {
      isLoging = true;
        });
      var resp = await _apiService!.loginResponse(email, password);
      if (resp == 'success') {
        setState(() {
          isLoging = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        setState(() {
          isLoging = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1000),
          backgroundColor: Colors.red,
          content: Text(
            resp.toUpperCase(),
            style: const TextStyle(fontSize: 16),
          ),
        ));
      }
    }
  }

  @override
  void initState() {
    _apiService = ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "InterMovie",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "All you're movie information needs at your fingertips.",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              TextFormField(
                validator: (val) {
                  return val!.isEmpty ? "Username Cant Be Empty" : null;
                },
                decoration: const InputDecoration(hintText: "Username"),
                onChanged: (val) {
                  email = val;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) {
                  return val!.isEmpty ? "Password Cant Be Empty" : null;
                },
                decoration: const InputDecoration(hintText: "Password"),
                onChanged: (val) {
                  password = val;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: !isLoging ? const Text("LogIn") : Platform.isAndroid
                ? const CircularProgressIndicator(color: Colors.white,)
                : const CupertinoActivityIndicator()),
              ),
              const SizedBox(
                height: 18,
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
