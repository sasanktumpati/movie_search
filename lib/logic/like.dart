import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LikeButton extends StatelessWidget {
  final String imdbId;

  const LikeButton( {Key? key, required this.imdbId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LikeButtonModel(imdbId: imdbId),
      child: _LikeButton(),
    );
  }
}

class LikeButtonModel extends ChangeNotifier {
  final String imdbId;
  late SharedPreferences _prefs;

  LikeButtonModel({required this.imdbId}) {
    _initPrefs();
  }

  bool _isLiked = false;

  bool get isLiked => _isLiked;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _isLiked = _prefs.getBool('liked_$imdbId') ?? false;
    notifyListeners();
  }

  Future<void> toggleLikedStatus() async {
    _isLiked = !_isLiked;
    await _prefs.setBool('liked_$imdbId', _isLiked);
    notifyListeners();
  }
}

class _LikeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final likeButtonModel = Provider.of<LikeButtonModel>(context);
    return IconButton(
      icon: Icon(
        likeButtonModel.isLiked ? Icons.favorite : Icons.favorite_border,
        color: likeButtonModel.isLiked ? Colors.red : null,
      ),
      onPressed: () => likeButtonModel.toggleLikedStatus(),
    );
  }
}

