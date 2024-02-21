import 'package:url_launcher/url_launcher.dart';

Future<void> openTrailer(String youtubeTrailerKey) async {
  String url = 'https://www.youtube.com/watch?v=$youtubeTrailerKey';

  if(url.isNotEmpty) {
    if(await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);

    } else {
      throw 'Could Not launch $url ';
    }
  }
}