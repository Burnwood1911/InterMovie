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

  signIn() async {
    if (_formKey.currentState!.validate()) {
      var resp = await _apiService!.loginResponse(email, password);
      if (resp == 'success') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          duration: const Duration(milliseconds: 1000),
          backgroundColor: Colors.red,
          content: Text(
            resp,
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                    child: const Text("LogIn")),
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
