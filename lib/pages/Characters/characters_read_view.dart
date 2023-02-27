import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/pages/Characters/widget/character_image.dart';
import 'package:rickandmorty/pages/Characters/widget/character_read_info.dart';

import '../../riverpod/character_state.dart';

class CharacterRead extends ConsumerStatefulWidget {
  static const routerName = "/character/read";
  const CharacterRead({super.key, required this.id});
  final int id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterReadState();
}

class _CharacterReadState extends ConsumerState<CharacterRead> {
  @override
  Widget build(BuildContext context) {
    ref.watch(characterProvider);
    final character = ref.read(characterProvider.notifier).filter(widget.id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CharacterImage(image: character.image),
                ),
                CharacterInfo(
                  title: "Nombre: ",
                  text: character.name,
                ),
                CharacterInfo(
                  title: "Estado: ",
                  text: character.status,
                ),
                CharacterInfo(
                  title: "info: ",
                  text:
                      '''Origen: ${character.origin.name}, locacion actual: ${character.location.name}''',
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed("/character/edit", arguments: character);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.edit),
                        Text("Editar"),
                      ],
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
