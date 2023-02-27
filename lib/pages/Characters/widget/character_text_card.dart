import 'package:flutter/material.dart';

class CharacterTextCard extends StatefulWidget {
  const CharacterTextCard(
      {super.key, required this.container, required this.text});
  final String container;
  final String text;

  @override
  State<CharacterTextCard> createState() => _CharacterTextCardState();
}

class _CharacterTextCardState extends State<CharacterTextCard> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      maxLines: 4,
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: widget.container,
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: Colors.black),
          )
        ],
      ),
    );
  }
}
