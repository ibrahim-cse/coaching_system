import 'dart:io' as io;

import 'package:coaching_system/model/payment_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PaymentDbHelper {
  static Database? _db;

  static const String dbName = 'payment.db';
  static const String tableUser = 'payment';
  static const int version = 1;

  static const String cPaymentID = 'paymentID';
  static const String cCardNumber = 'cardNumber';
  static const String cCardExpire = 'cardExpire';
  static const String cCVV = 'cvv';
  static const String cAmount = 'amount';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableUser ("
        " $cPaymentID int, "
        " $cCardNumber TEXT, "
        " $cCardExpire TEXT,"
        " $cCVV TEXT,"
        " $cAmount TEXT,"
        "PRIMARY KEY ($cPaymentID)"
        ")");
  }

  Future<int> saveData(PaymentModel payment) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableUser, payment.toMap());
    return res;
  }

  Future<PaymentModel?> getLoginUser(String cardNumber, String cvv) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableUser WHERE "
        "$cCardNumber = '$cardNumber' AND "
        "$cCVV = '$cvv'");

    if (res.isNotEmpty) {
      return PaymentModel.fromMap(res.first);
    }
    return null;
  }
}
