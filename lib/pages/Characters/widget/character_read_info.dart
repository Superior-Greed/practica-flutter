import 'package:flutter/material.dart';

class CharacterInfo extends StatefulWidget {
  CharacterInfo({super.key, required this.text, required this.title});
  String title;
  String text;
  @override
  State<CharacterInfo> createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shadowColor: Colors.greenAccent,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.lightGreen //Theme.of(context).colorScheme.outline,
              ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: RichText(
            text: TextSpan(
              text: widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24),
              children: <TextSpan>[
                TextSpan(
                  text: widget.text,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
