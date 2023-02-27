import 'package:flutter/material.dart';

class CharacterInputText extends StatefulWidget {
  CharacterInputText(
      {super.key, required this.constructorG, required this.description});
  String description;
  TextEditingController constructorG;
  @override
  State<CharacterInputText> createState() => _CharacterInputTextState();
}

class _CharacterInputTextState extends State<CharacterInputText> {
  Color color = Colors.greenAccent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
      child: Focus(
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            color = Colors.green;
          } else {
            color = Colors.greenAccent;
          }
          setState(() {});
        },
        child: TextFormField(
          autofocus: false,
          style: const TextStyle(
            fontSize: 24,
          ),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.greenAccent,
              ),
            ),
            focusColor: Colors.greenAccent,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
              ),
            ),
            labelStyle: TextStyle(
              color: color,
            ),
            iconColor: color,
            icon: Icon(
              Icons.person,
              color: color,
            ),
            hintText: widget.description,
            labelText: '${widget.description} *',
          ),
          controller: widget.constructorG,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor pon el texto';
            }
            return null;
          },
          onSaved: (value) {
            widget.constructorG.text = value!;
          },
          onChanged: (value) {
            //widget.constructorG.text = value;
          },
        ),
      ),
    );
  }
}
