// ignore_for_file: deprecated_member_use

import 'package:coaching_system/common/get_text_form_field.dart';
import 'package:coaching_system/common/take_signup_photo.dart';
import 'package:coaching_system/common/toast_helper.dart';
import 'package:coaching_system/database_handler/db_helper.dart';
import 'package:coaching_system/model/user_model.dart';
import 'package:flutter/material.dart';
import 'login_form.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPhone = TextEditingController();
  final _conAddress = TextEditingController();
  final _conPassword = TextEditingController();
  final _conConfirmPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uName = _conUserName.text;
    String uEmail = _conEmail.text;
    String uPhone = _conPhone.text;
    String uAddress = _conAddress.text;
    String uPassword = _conPassword.text;
    String uConfirmPassword = _conConfirmPassword.text;

    if (_formKey.currentState!.validate()) {
      if (uPassword != uConfirmPassword) {
        MyAlertDialog(context, "Password Did Not Match");
      } else {
        _formKey.currentState!.save();

        UserModel uModel =
            UserModel(uName, uEmail, uPhone, uAddress, uConfirmPassword);

        await dbHelper.saveData(uModel).then((userData) {
          MyAlertDialog(context, "Successfully Saved");

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginForm()));
        }).catchError((error) {
          print(error);
          MyAlertDialog(context, "Data Saving Failed");
        });
      }
    }
  }

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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignupPhoto(),
                MyTextFormField(
                  controller: _conUserName,
                  inputType: TextInputType.name,
                  myhint: 'Name',
                  myicon: Icons.person,
                ),
                const SizedBox(height: 10.0),
                MyTextFormField(
                  controller: _conEmail,
                  inputType: TextInputType.emailAddress,
                  myhint: 'Email',
                  myicon: Icons.email,
                ),
                const SizedBox(height: 10.0),
                MyTextFormField(
                  controller: _conPhone,
                  inputType: TextInputType.phone,
                  myhint: 'Phone',
                  myicon: Icons.phone,
                ),
                const SizedBox(height: 10.0),
                MyTextFormField(
                  controller: _conAddress,
                  myhint: 'Address',
                  myicon: Icons.home,
                ),
                const SizedBox(height: 10.0),
                MyTextFormField(
                  controller: _conPassword,
                  myhint: 'Password',
                  myicon: Icons.lock,
                  isObscureText: true,
                ),
                const SizedBox(height: 10.0),
                MyTextFormField(
                  controller: _conConfirmPassword,
                  myhint: 'Confirm password',
                  myicon: Icons.lock,
                  isObscureText: true,
                ),
                Container(
                  margin: const EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: signUp,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have have an Account?',
                      ),
                      FlatButton(
                        textColor: Colors.blue,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginForm()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
