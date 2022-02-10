import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  final String image;
  const ImageFullScreen({Key? key, required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              '${image}',
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}