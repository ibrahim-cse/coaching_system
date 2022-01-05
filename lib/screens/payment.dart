import 'package:coaching_system/common/get_text_form_field.dart';
import 'package:coaching_system/common/toast_helper.dart';
import 'package:flutter/material.dart';

import 'course_detail.dart';

class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _formKey = GlobalKey<FormState>();

  final _conCardNumber = TextEditingController();
  final _conExpire = TextEditingController();
  final _conCVV = TextEditingController();
  final _conAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        key: _formKey,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            controller: _conExpire,
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
              onPressed: () {
                MyAlertDialog(context, 'Payment Successful');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => CourseDetail()),
                    (Route<dynamic> route) => false);
              },
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }
}
