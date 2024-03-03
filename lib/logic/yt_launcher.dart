import 'package:url_launcher/url_launcher.dart';

void openTrailer(dynamic youtubeTrailerKey) async {
  final String ytUrl = 'https://www.youtube.com/watch?v=$youtubeTrailerKey';
  Uri uri = Uri.parse(ytUrl);
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $uri');
  }
}

// Future<void> openTrailer(dynamic youtubeTrailerKey) async {
//   String url = 'https://www.youtube.com/watch?v=$youtubeTrailerKey';
//   Uri error = Uri.parse('https://i.ibb.co/S794thq/2.jpg');

//   if (url.isNotEmpty) {
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//     } else {
//       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//     }
//   }
// }
