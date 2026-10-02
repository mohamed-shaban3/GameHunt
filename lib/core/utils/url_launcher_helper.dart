import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncherHelper {
  static Future<void> launchUrlString(String url) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        log('Could not launch $url');
      }
    } catch (e) {
      log('Error launching url: $e');
    }
  }
}