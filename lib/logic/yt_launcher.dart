import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openTrailer(String youtubeTrailerKey) async {
  String url = 'https://www.youtube.com/watch?v=$youtubeTrailerKey';

  if (url.isNotEmpty) {
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could Not launch $url ';
    }
  }
}

class TrailerButton extends StatelessWidget {
  final String youtubeTrailerKey;

  TrailerButton({required this.youtubeTrailerKey});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => openTrailer(youtubeTrailerKey),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      child: Text('Watch Trailer'),
    );
  }
}
