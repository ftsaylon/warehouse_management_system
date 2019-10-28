// Author: Saylon, Francis T. 
// Project Name: Solar Warehouse Management System

import 'package:flutter/foundation.dart';

// Model for Address Class
class Address {
  final String street;
  final String city;
  final String province;
  final String country;
  final int postalCode;

  Address({
    @required this.street,
    @required this.city,
    @required this.province,
    @required this.country,
    @required this.postalCode,
  });
}
