import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeButton extends StatefulWidget {
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLiked;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _isLiked = false;
    _loadLikedStatus();
  }

  Future<void> _loadLikedStatus() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLiked = _prefs.getBool('liked') ?? false;
    });
  }

  Future<void> _toggleLikedStatus() async {
    setState(() {
      _isLiked = !_isLiked;
    });
    await _prefs.setBool('liked', _isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: _isLiked ? Colors.red : null,
      ),
      onPressed: _toggleLikedStatus,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Like Button Example'),
      ),
      body: Center(
        child: LikeButton(),
      ),
    ),
  ));
}
