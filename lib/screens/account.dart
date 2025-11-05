import 'package:dictionary_app/extra.dart';
import 'package:dictionary_app/fieldfortext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps_providers/usernamenotif.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late TextEditingController editor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 1),
              Text('Edit your username'),

              // SizedBox(height: s0),
              Fieldfortext(
                hintText: 'Edit name',
                labelText: '',
                controller: editor,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<Usernamenotif>().newname(editor.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Extra();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
