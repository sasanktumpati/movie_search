import 'package:url_launcher/url_launcher.dart';

Future<void> openTrailer(dynamic youtubeTrailerKey) async {
  String url = 'https://www.youtube.com/watch?v=$youtubeTrailerKey';

  if (url.isNotEmpty) {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could Not launch $url';
    }
  }
}
