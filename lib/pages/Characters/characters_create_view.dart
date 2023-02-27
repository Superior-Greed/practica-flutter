import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/models/character_model.dart';
import 'package:rickandmorty/pages/Characters/widget/character_input_text.dart';
import 'package:rickandmorty/riverpod/character_state.dart';

class CharacterCreate extends ConsumerStatefulWidget {
  static const routerName = "/character/create";
  const CharacterCreate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CharacterCreateState();
}

class _CharacterCreateState extends ConsumerState<CharacterCreate> {
  static const List<String> status = <String>['vivo', 'muerto', 'desconosido'];
  String statusValue = '';

  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController origin = TextEditingController();
  String image = '';

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    statusValue = status.first;
    name.text = '';
    location.text = '';
    origin.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Creacion de personaje"),
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
                          Character character = Character(
                              id: ref.watch(characterProvider).length + 1,
                              name: name.text,
                              status: statusValue,
                              species: '',
                              type: '',
                              gender: '',
                              created: DateTime.now(),
                              episode: [],
                              image: image,
                              location: Location(name: location.text, url: ''),
                              origin: Location(name: origin.text, url: ''),
                              url: '');
                          ref.read(characterProvider.notifier).add(character);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Crear",
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
