import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onPressed;

  MovieCard({super.key, required this.title, required this.imageUrl, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )
                      : Container(),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Like'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
