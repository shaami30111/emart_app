import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/image_model.dart';

///---@author Mudassir For Storing Images in Gallery Created Method Channel 'SaveImagesToGallery'
const platform = MethodChannel('saveImagesIntoGalleryChannel');
const String photoGalleryChildDirectoryPath = "aiArtGallery";

Future<void> launchUrlCustom(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

void shareApp(BuildContext context) async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String playStoreLink =
        "https://play.google.com/store/apps/details?id=$packageName";
    String shareMessage =
        "Let me recommend you this application\n\n$playStoreLink";
    Share.share(
      shareMessage,
      subject: appName,
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

String calculateTimeC(DateTime time) {
  DateTime a = time;
  DateTime b = DateTime.now();

  Duration difference = b.difference(a);

  int days = difference.inDays;
  int hours = difference.inHours % 24;
  int minutes = difference.inMinutes % 60;
  int seconds = difference.inSeconds % 60;
  String result = '';

  if (days != 0) {
    result += '$days day(s) ';
  } else if (hours != 0) {
    result += '$hours hour(s) ';
  } else if (minutes != 0) {
    result += '$minutes minute(s) ';
  } else if (seconds != 0) {
    result += '$seconds second(s)';
  }

  return result;
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}

Future<String> copyBytesToFile(List<int> bytes, String fileName) async {
  try {
    final Directory tempDir = await getTemporaryDirectory();
    final String childDirPath = '${tempDir.path}/aiArtGenerator';
    final Directory childDir = Directory(childDirPath);
    if (await File('$childDirPath/$fileName').exists()) {
      await File('$childDirPath/$fileName').delete();
    }
    debugPrint("objectChildDirectory$childDir");
    await childDir.create(recursive: true);
    final File tempFile = File('$childDirPath/$fileName');
    await tempFile.writeAsBytes(bytes);
    if (kDebugMode) {
      print('Bytes copied to file: ${tempFile.path}');
    }
    return tempFile.path;
  } catch (e) {
    if (kDebugMode) {
      print('Error copying bytes to file: $e');
    }
  }
  return "";
}

void printUnlimited(String tag, String message) {
  const maxPrintSize = 1000;
  final chunks = (message.length / maxPrintSize).ceil();
  for (var i = 0; i < chunks; i++) {
    final startIndex = i * maxPrintSize;
    final endIndex = (i + 1) * maxPrintSize;
    final chunk = message.substring(startIndex, endIndex);
    if (kDebugMode) {
      print('$tag ----> $chunk');
    }
  }
}

Future<String> saveImageToGallery(String filePath) async {
  try {
    var returnPath = await platform
        .invokeMethod('saveImageToGallery', {'filePath': filePath});
    return returnPath;
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print(e.details);
    }
    return "";
  }
}

void rateUsMethod(BuildContext context) async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    String playStoreLink =
        "https://play.google.com/store/apps/details?id=$packageName";
    await launchUrl(Uri.parse(playStoreLink));
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

Future<bool> requestPermissions() async {
  var status = await Permission.storage.status;
  if (status.isGranted) {
    return true;
  } else {
    var result = await Permission.storage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}

Future<bool> requestPermissions13() async {
  var status = await Permission.photos.status;
  if (status.isGranted) {
    return true;
  } else {
    var result = await Permission.photos.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
Future<int> checkAndroidVersion() async {
  AndroidDeviceInfo androidInfo;
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }
  return 9;
}

Future<String> deleteImageFile(String imagePath) async {
  try {
    var result = await platform
        .invokeMethod('deleteImageFile', {'imagePath': imagePath});
    if (kDebugMode) {
      print("objectDeleteLog$result");
    }
    return result;
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
    return "";
  }
}



///----Used Native Method For Sharing Only Android
Future<String> startFileShareOnWhatsApp(String imagePath) async {
  try {
    var result = await platform
        .invokeMethod('startFileShareOnWhatsApp', {'imagePath': imagePath});
    return result;
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
    return "";
  }
}

Future<String> startFileShareOnX(String imagePath) async {
  try {
    var result = await platform
        .invokeMethod('startFileShareOnX', {'imagePath': imagePath});
    return result;
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
    return "";
  }
}
Future<String> startFileShareOnFacebook(String imagePath) async {
  try {
    var result = await platform
        .invokeMethod('startFileShareOnFacebook', {'imagePath': imagePath});
    return result;
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
    return "";
  }
}

Future<String> startFileShareOnInstagram(String imagePath) async {
  try {
    var result = await platform
        .invokeMethod('startFileShareOnInstagram', {'imagePath': imagePath});
    return result;
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
    return "";
  }
}

Future<String> startFileShare(String imagePath) async {
  try {
    var result =
    await platform.invokeMethod('startFileShare', {'imagePath': imagePath});
    return result;
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
    return "";
  }
}


void openPrivacyUrl(BuildContext context) async {
  const url =
      'https://pixaprobackgroundremover.blogspot.com/2023/10/privacy-policy-last-updated-17-2023.html';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

void openTermOfUseUrl(BuildContext context) async {
  const url =
      'https://pixaprobackgroundremover.blogspot.com/2023/10/ai-background-remover-retouch.html';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

void openRestoreUrl(BuildContext context) async {
  const url = 'https://play.google.com/store/account/subscriptions';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}