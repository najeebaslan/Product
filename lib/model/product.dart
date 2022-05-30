// ignore_for_file: non_constant_identifier_names

class Product {
  int? VarFID;
  int? VarCID;
  int? VarAreaCode;
  int? VarAge;
  int? VarB;
  int? VarF;
  List<OrderLines>? orderLines;

  Product(
      {this.VarFID,
      this.VarAge,
      this.VarAreaCode,
      this.VarB,
      this.VarCID,
      this.VarF,
      this.orderLines});

  Product.fromJson(Map<String, dynamic> json) {
    VarFID = json['VarFID'];
    VarAge = json['VarAge'];
    VarAreaCode = json['VarAreaCode'];
    VarB = json['VarB'];
    VarCID = json['VarCID'];
    VarF = json['VarF'];
    if (json['OrderLines'] != null) {
      orderLines = <OrderLines>[];
      json['OrderLines'].forEach((v) {
        orderLines!.add(OrderLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['VarFID'] = VarFID;
    data['VarAge'] = VarAge;
    data['VarAreaCode'] = VarAreaCode;
    data['VarB'] = VarB;
    data['VarCID'] = VarCID;
    data['VarF'] = VarF;
    if (orderLines != null) {
      data['OrderLines'] = orderLines!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class OrderLines {
  int? price;
  int? discountNo_;

  OrderLines({
    this.price,
    this.discountNo_,
  });

  OrderLines.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    discountNo_ = json['discount No_'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['discount No_'] = discountNo_;

    return data;
  }
}
