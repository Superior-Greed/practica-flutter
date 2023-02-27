import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/models/character_model.dart';
import 'package:rickandmorty/pages/Characters/widget/character_image.dart';
import 'package:rickandmorty/pages/Characters/widget/character_text_card.dart';
import 'package:rickandmorty/riverpod/character_state.dart';

class CharacterCard extends ConsumerStatefulWidget {
  CharacterCard({super.key, required this.character});
  Character character;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterCardState();
}

class _CharacterCardState extends ConsumerState<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.greenAccent,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.lightGreen //Theme.of(context).colorScheme.outline,
            ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: 250,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed("/character/read", arguments: widget.character.id);
          },
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: CharacterTextCard(
                            text: "Nombre: ",
                            container: widget.character.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: CharacterTextCard(
                            text: "Estado: ",
                            container: widget.character.status,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: CharacterTextCard(
                            text: "Info: ",
                            container:
                                '''Origen: ${widget.character.origin.name}, locacion actual: ${widget.character.location.name}''',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shadowColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                              onPressed: () {
                                ref
                                    .read(characterProvider.notifier)
                                    .delete(widget.character.id);
                              },
                              child: Row(children: const [
                                Text("Borrar "),
                                Icon(Icons.remove_circle_outline),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CharacterImage(image: widget.character.image),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
