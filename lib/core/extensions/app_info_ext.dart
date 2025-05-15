import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

extension BuildContextExtension on BuildContext {
  static late PackageInfo _packageInfo;

  String get appName => _packageInfo.appName;

  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }
}
