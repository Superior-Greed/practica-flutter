import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/models/character_model.dart';
import 'package:rickandmorty/pages/Characters/widget/character_input_text.dart';
import 'package:rickandmorty/riverpod/character_state.dart';

class CharacterEdit extends ConsumerStatefulWidget {
  static const routerName = "/character/edit";
  const CharacterEdit({super.key, required this.character});
  final Character character;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterEditState();
}

class _CharacterEditState extends ConsumerState<CharacterEdit> {
  static const List<String> status = <String>['vivo', 'muerto', 'desconosido'];
  String statusValue = '';

  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController origin = TextEditingController();
  late String image = "";

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    statusValue = status
            .where((element) => element == widget.character.status)
            .isNotEmpty
        ? status.where((element) => element == widget.character.status).first
        : status.first;
    name.text = widget.character.name;
    location.text = widget.character.location.name;
    origin.text = widget.character.origin.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.character.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () async {
                        image =
                            await ref.read(characterProvider.notifier).image();
                        setState(() {
                          statusValue;
                          name.text;
                          location.text;
                          origin.text;
                          image;
                        });
                      },
                      child: image.isNotEmpty
                          ? Image.file(File(image))
                          : const Icon(Icons.add_a_photo_outlined,
                              size: 200.0,
                              weight: double.infinity,
                              shadows: [Shadow(color: Colors.black)]),
                    ),
                  ),
                ),
                CharacterInputText(
                  description: "Name",
                  constructorG: name,
                ),
                CharacterInputText(
                  description: "Locacion",
                  constructorG: location,
                ),
                CharacterInputText(
                  description: "Origen",
                  constructorG: origin,
                ),
                DropdownButton<String>(
                  value: statusValue,
                  elevation: 16,
                  style: const TextStyle(color: Colors.green),
                  underline: Container(
                    height: 2,
                    color: Colors.lightGreen,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      statusValue = value!;
                      name.text;
                      location.text;
                      origin.text;
                      image;
                    });
                  },
                  items: status.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.lightGreen),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shadowColor: Colors.green,
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          widget.character.status = statusValue;
                          widget.character.name = name.text;
                          widget.character.location.name = location.text;
                          widget.character.origin.name = origin.text;
                          widget.character.image =
                              image.isEmpty ? widget.character.image : image;
                          ref
                              .read(characterProvider.notifier)
                              .edit(widget.character.id, widget.character);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Guardar",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
