import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/home/data/models/prayer_model.dart';

List<PrayerModel> prayers = [
  PrayerModel(
    prayerName: 'Fajr',
    prayerTime: DateFormat('hh:mm').format(DateTime.now()),
    prayerIconColor: AppColors.blueColor,
    prayerIcon: Icons.wb_twilight,
  ),
  PrayerModel(
    prayerName: 'Dhuhr',
    prayerTime: DateFormat('hh:mm').format(DateTime.now()),
    prayerIconColor: AppColors.accent,
    prayerIcon: Icons.wb_sunny_rounded,
  ),
  PrayerModel(
    prayerName: 'Asr',
    prayerTime: DateFormat('hh:mm').format(DateTime.now()),
    prayerIconColor: AppColors.kPrimaryColor,
    prayerIcon: Icons.sunny,
  ),
  PrayerModel(
    prayerName: 'Maghrib',
    prayerTime: DateFormat('hh:mm').format(DateTime.now()),
    prayerIconColor: AppColors.financeYellow,
    prayerIcon: Icons.wb_twilight,
  ),
  PrayerModel(
    prayerName: 'Isha',
    prayerTime: DateFormat('hh:mm').format(DateTime.now()),
    prayerIconColor: AppColors.blueColor,
    prayerIcon: Icons.bedtime,
  ),
];
