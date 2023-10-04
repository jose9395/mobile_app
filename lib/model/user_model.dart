class User {
  final String? id;
  final String? name;
  final String? tradeName;
  final String? mobileNo;
  final String? whatsAppNo;
  final String? address;
  final String? gstNumber;

  const User(
      {this.id,
      this.name,
      this.tradeName,
      this.mobileNo,
      this.whatsAppNo,
      this.address,
      this.gstNumber});

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      tradeName: json["tradeName"],
      mobileNo: json["mobileNo"],
      whatsAppNo: json["whatsAppNo"],
      address: json["address"],
      gstNumber: json["gstNumber"]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tradeName': tradeName,
      'mobileNo': mobileNo,
      'whatsAppNo': whatsAppNo,
      'address': address,
      'gstNumber': gstNumber
    };
  }

}
