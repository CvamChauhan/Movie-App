import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'register_data.g.dart';

@HiveType(typeId: 1)
class RegisterData {
  @HiveField(0)
  String firstName;

  @HiveField(1)
  String secondName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  String mobile;
  RegisterData(
      {required this.firstName,
      required this.secondName,
      required this.email,
      required this.password,
      required this.mobile});
}
