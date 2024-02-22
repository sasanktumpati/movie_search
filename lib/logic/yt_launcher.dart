import 'package:url_launcher/url_launcher.dart';

Future<void> openTrailer(String youtubeTrailerKey) async {
  String url = 'https://www.youtube.com/watch?v=$youtubeTrailerKey';

  if (url.isNotEmpty) {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could Not launch $url';
    }
  }
}

