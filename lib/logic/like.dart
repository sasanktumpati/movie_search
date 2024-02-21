import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LikeButtonModel(),
      child: _LikeButton(),
    );
  }
}

class LikeButtonModel extends ChangeNotifier {
  bool _isLiked = false;
  late SharedPreferences _prefs;

  bool get isLiked => _isLiked;

  Future<void> loadLikedStatus() async {
    _prefs = await SharedPreferences.getInstance();
    _isLiked = _prefs.getBool('liked') ?? false;
    notifyListeners();
  }

  Future<void> toggleLikedStatus() async {
    _isLiked = !_isLiked;
    await _prefs.setBool('liked', _isLiked);
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

