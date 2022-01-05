import 'package:coaching_system/common/gen_login_signup_header.dart';
import 'package:coaching_system/screens/login_form.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Container(
              width: 57,
              height: 57,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      'images/spectrum.jpg',
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
              'Spectrum Learning Center',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const GenLoginSignupHeader(
              headerName: 'Choose User',
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginForm()),
                );
              },
              child: const Text('Login as student',
                  style: TextStyle(fontSize: 20.0)),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginForm()),
                );
              },
              child: const Text('Login as teacher',
                  style: TextStyle(fontSize: 20.0)),
            )
          ],
        ),
      ),
    );
  }
}
