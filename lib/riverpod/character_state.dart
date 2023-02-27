import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

import '../models/character_model.dart';

Future<List<Character>> fetchRick(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://rickandmortyapi.com/api/character'));

  return characterFromListjson(response.body);
}

class CharacterState extends StateNotifier<List<Character>> {
  CharacterState() : super(<Character>[]);

  void addAll(List<Character> characters) {
    state = characters;
  }

  void reload() async {
    state = await fetchRick(http.Client());
  }

  void edit(int id, Character character) {
    int range = state.indexWhere((element) => element.id == id);
    state[range] = character;
    state = [...state];
  }

  void delete(int id) {
    state = state.where((element) => element.id != id).toList();
  }

  void add(Character character) {
    state = [character, ...state];
  }

  Character filter(int id) {
    return state.where((element) => element.id == id).first;
  }

  Future<String> image() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path.toString());
      return file.path;
    } else {
      return "";
    }
  }
}

final characterProvider =
    StateNotifierProvider<CharacterState, List<Character>>((ref) {
  return CharacterState();
});

// class CharacterState extends Notifier<List<Character>> {
//   @override
//   build() {
//     return <Character>[];
//   }

//   void addAll(List<Character> characters) {
//     state = characters;
//   }

//   void reload() async {
//     state = await fetchRick(http.Client());
//   }

//   void edit(int id, Character character) {
//     int range = state.indexWhere((element) => element.id == id);
//     state[range] = character;
//     state = [...state];
//   }

//   void delete(int id) {
//     state = state.where((element) => element.id != id).toList();
//   }

//   void add(Character character) {
//     state = [character, ...state];
//   }

//   Character filter(int id) {
//     return state.where((element) => element.id == id).first;
//   }

//   Future<String> image() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       File file = File(result.files.single.path.toString());
//       return file.path;
//     } else {
//       return "";
//     }
//   }
// }

// final characterProvider =
//     NotifierProvider<CharacterState, List<Character>>(CharacterState.new);

final characterFuture = FutureProvider<List<Character>>((ref) async {
  final charaters = ref.watch(characterProvider);
  if (charaters.isEmpty) {
    final state = await fetchRick(http.Client());
    ref.read(characterProvider.notifier).addAll(state);
    return state;
  }
  return charaters;
});
