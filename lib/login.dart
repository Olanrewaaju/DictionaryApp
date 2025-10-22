import 'package:dictionary_app/apps_providers/wordvalue.dart';
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
  String errorName = '';
  bool errorVal = true;
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

  void initState() {
    super.initState();
    // validate as the user types
    user.addListener(() {
      final isValid = user.text.trim().length >= 3;
      if (errorVal == isValid) {
        // flip because errorVal is `true` when invalid
        setState(() {
          errorVal = !isValid;
        });
      } else if (!isValid && errorVal != true) {
        setState(() => errorVal = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final errorName = context.watch<Usernamenotif>().newname(user.text);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                child: errorVal
                    ? Text(
                        'Invalid Username (Input more than three letters)',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      )
                    : Text(''),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: errorVal
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.grey),
                        ),
                        onPressed: null,
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ElevatedButton(
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
