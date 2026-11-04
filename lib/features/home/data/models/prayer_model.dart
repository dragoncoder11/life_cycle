import 'package:flutter/material.dart';

class PrayerModel {
  final String prayerName;
  final String prayerTime;
  final Color? prayerIconColor;
  final IconData prayerIcon;
  final bool? isTime;

  PrayerModel({
    required this.prayerName,
    required this.prayerTime,
    required this.prayerIconColor,
    required this.prayerIcon,
     this.isTime,
  });
}
