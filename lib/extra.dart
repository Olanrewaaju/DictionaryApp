import 'package:dictionary_app/bottom_nav.dart';
import 'package:flutter/material.dart';

class Extra extends StatefulWidget {
  const Extra({super.key});

  @override
  State<Extra> createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isloading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Text('Your Name has been changed already'),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BottomNavBar();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
