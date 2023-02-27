import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/pages/Characters/widget/character_card.dart';

import '../../riverpod/character_state.dart';

class CharacterIndex extends ConsumerStatefulWidget {
  static const routeName = "/character/index";
  const CharacterIndex({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterIndexState();
}

class _CharacterIndexState extends ConsumerState<CharacterIndex> {
  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(characterFuture);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("inicio"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/character/create");
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(characterProvider.notifier).reload(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: characters.when(
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Error $err'),
              data: (characterList) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var character in characterList) ...[
                      CharacterCard(character: character),
                    ]
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
