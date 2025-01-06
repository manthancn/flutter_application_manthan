// ignore_for_file: non_constant_identifier_names

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class User {
  User({
    // required this.id,
    required this.title,
    required this.age,
    // this.color = Colors.orange,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final int age;
  // final Color color;
}

class DynamicUser {
  const DynamicUser({
    required this.id,
    required this.gender,
    required this.date_of_birth,
    required this.job,
    required this.city,
    required this.zipcode,
    required this.latitude,
    required this.longitude,
    required this.profile_picture,
    required this.email,
    required this.last_name,
    required this.first_name,
    required this.phone,
    required this.street,
    required this.state,
    required this.country,
  });
  final String id;
  final String gender;
  final String date_of_birth;
  final String job;
  final String city;
  final String zipcode;
  final String latitude;
  final String longitude;
  final String profile_picture;
  final String email;
  final String last_name;
  final String first_name;
  final String phone;
  final String street;
  final String state;
  final String country;
}
