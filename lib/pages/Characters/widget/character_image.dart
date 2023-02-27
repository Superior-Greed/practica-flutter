import 'dart:io';

import 'package:flutter/material.dart';

class CharacterImage extends StatefulWidget {
  CharacterImage({super.key, required this.image});
  String image;

  @override
  State<CharacterImage> createState() => _CharacterImageState();
}

class _CharacterImageState extends State<CharacterImage> {
  @override
  Widget build(BuildContext context) {
    return widget.image.contains("http") || widget.image == ''
        ? Image.network(
            widget.image == ''
                ? "https://indiehoy.com/wp-content/uploads/2022/08/rick-and-morty.jpg"
                : widget.image,
            fit: BoxFit.fill,
            width: double.infinity,
            height: 500,
          )
        : Image.file(
            File(widget.image),
            fit: BoxFit.fill,
            width: double.infinity,
            height: 500,
          );
  }
}
