import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open Google Maps';
    }
  }

  // Alternative: Open in Google Maps app specifically
  static Future<void> openInGoogleMapsApp(double latitude, double longitude) async {
    String googleUrl = 'comgooglemaps://?q=$latitude,$longitude';
    String fallbackUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    
    try {
      // Try to open in Google Maps app
      if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
      } else {
        // Fallback to web version
        if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
          await launchUrl(Uri.parse(fallbackUrl));
        } else {
          throw 'Could not launch maps';
        }
      }
    } catch (e) {
      // Final fallback
      if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
        await launchUrl(Uri.parse(fallbackUrl));
      }
    }
  }
}