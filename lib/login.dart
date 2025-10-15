import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fieldfortext.dart';
import 'apps_providers/usernamenotif.dart';
import 'bottom_nav.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController user = TextEditingController();
  final TextEditingController password = TextEditingController();
  void onPressed() {
    // set username in provider first so Home reads the updated value
    context.read<Usernamenotif>().newname(user.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BottomNavBar();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Fieldfortext(
                controller: password,
                hintText: 'Enter your Email',
                labelText: 'Email',
              ),
              SizedBox(height: 50),
              Fieldfortext(
                controller: user,
                hintText: 'Enter your username',
                labelText: 'Username',
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
