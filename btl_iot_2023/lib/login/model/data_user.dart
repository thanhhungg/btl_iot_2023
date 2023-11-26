
import 'package:hive/hive.dart';
part 'data_user.g.dart';
@HiveType(typeId: 0)
class DataUser extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? lcNumber;
  @HiveField(2)
  int? age;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? account;
  @HiveField(5)
  String? password;

  DataUser(
      {this.name,
        this.lcNumber,
        this.age,
        this.email,
        this.account,
        this.password});

  DataUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lcNumber = json['lc_number'];
    age = json['age'];
    email = json['email'];
    account = json['account'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lc_number'] = this.lcNumber;
    data['age'] = this.age;
    data['email'] = this.email;
    data['account'] = this.account;
    data['password'] = this.password;
    return data;
  }
}
