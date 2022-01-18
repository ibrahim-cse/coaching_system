import 'package:coaching_system/common/get_text_form_field.dart';
import 'package:coaching_system/common/toast_helper.dart';
import 'package:coaching_system/database_handler/payment_db_helper.dart';
import 'package:coaching_system/model/payment_model.dart';
import 'package:flutter/material.dart';

import 'lecture_videos.dart';

class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _formKey = GlobalKey<FormState>();

  final _conCardNumber = TextEditingController();
  final _conCardExpire = TextEditingController();
  final _conCVV = TextEditingController();
  final _conAmount = TextEditingController();
  var paymentDbHelper;

  @override
  void initState() {
    super.initState();
    paymentDbHelper = PaymentDbHelper();
  }

  payment() async {
    String pCardNumber = _conCardNumber.text;
    String pCardExpire = _conCardExpire.text;
    String pCVV = _conCVV.text;
    String pAmount = _conAmount.text;

    if (_formKey.currentState!.validate()) {
      if (pCardNumber.isEmpty) {
        MyAlertDialog(context, "Please enter valid card number");
      } else {
        _formKey.currentState!.save();

        PaymentModel pModel =
            PaymentModel(pCardNumber, pCardExpire, pCVV, pAmount);

        await paymentDbHelper.saveData(pModel).then((paymentData) {
          MyAlertDialog(context, "Payment successful");

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CourseContents()));
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
        title: const Text('Payment'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your card details to pay for the course.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextFormField(
                  inputType: TextInputType.number,
                  myhint: 'Card Number',
                  myicon: Icons.credit_card,
                  controller: _conCardNumber,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextFormField(
                  inputType: TextInputType.text,
                  myhint: 'Expire Date',
                  myicon: Icons.date_range_outlined,
                  controller: _conCardExpire,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextFormField(
                  inputType: TextInputType.number,
                  myhint: 'CVV Code',
                  myicon: Icons.code,
                  controller: _conCVV,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextFormField(
                  inputType: TextInputType.text,
                  myhint: 'Enter Amount',
                  myicon: Icons.money_outlined,
                  controller: _conAmount,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: const EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    child: const Text(
                      'Pay',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: payment,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
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
