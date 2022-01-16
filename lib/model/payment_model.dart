class PaymentModel {
  PaymentModel(this.cardNumber, this.cardExpire, this.cvv, this.amount);

  String cardNumber = '';
  String cardExpire = '';
  String cvv = '';
  String amount = '';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'cardNumber': cardNumber,
      'cardExpire': cardExpire,
      'cvv': cvv,
      'amount': amount
    };
    return map;
  }

  PaymentModel.fromMap(Map<String, dynamic> map) {
    cardNumber = map['cardNumber'];
    cardExpire = map['cardExpire'];
    cvv = map['cvv'];
    amount = map['amount'];
  }
}
