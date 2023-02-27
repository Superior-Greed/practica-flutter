import 'package:flutter/material.dart';
import 'package:rickandmorty/models/character_model.dart';
import 'package:rickandmorty/pages/Characters/characters_create_view.dart';
import 'package:rickandmorty/pages/Characters/characters_edit_view.dart';
import 'package:rickandmorty/pages/home.dart';

import '../main.dart';
import '../pages/Characters/characters_index_view.dart';
import '../pages/Characters/characters_read_view.dart';
import '../widget/404_view.dart';

class Routes<T> {
  late String _name;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  late Icon _icon;

  Icon get icon => _icon;

  set icon(Icon value) {
    _icon = value;
  }

  late String _route;

  String get route => _route;

  set route(String value) {
    _route = value;
  }

  late T _arguments;

  T get arguments => _arguments;

  set arguments(T value) {
    _arguments = value;
  }

  Routes(String name, Icon icon, String route, T arguments) {
    _icon = icon;
    _name = name;
    _route = route;
    _arguments = arguments;
  }
}

class MyRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case MyHomePage.routeName:
        return MaterialPageRoute(builder: (context) {
          final titleArguments = settings.arguments as String;
          return MyHomePage(title: titleArguments);
        });
      case Home.routeName:
        return MaterialPageRoute(builder: (context) {
          return const Home();
        });
      case CharacterIndex.routeName:
        return MaterialPageRoute(builder: (context) {
          return const CharacterIndex();
        });
      case CharacterRead.routerName:
        return MaterialPageRoute(builder: (context) {
          final id = settings.arguments as int;
          return CharacterRead(id: id);
        });
      case CharacterEdit.routerName:
        return MaterialPageRoute(builder: (context) {
          final character = settings.arguments as Character;
          return CharacterEdit(
            character: character,
          );
        });
      case CharacterCreate.routerName:
        return MaterialPageRoute(builder: (context) {
          return const CharacterCreate();
        });
      default:
        return MaterialPageRoute(builder: (context) {
          return const Error404();
        });
    }
  }
}

var routesMenu = <Routes>[
  Routes(
      "home",
      const Icon(
        Icons.home,
        color: Colors.lightGreen,
        size: 24.0,
      ),
      Home.routeName,
      null),
  Routes(
      "Count",
      const Icon(
        Icons.add_box,
        color: Colors.lightGreen,
        size: 24.0,
      ),
      MyHomePage.routeName,
      "Contador basico"),
  Routes(
      "Personajes",
      const Icon(
        Icons.home_max,
        color: Colors.lightGreen,
        size: 24.0,
      ),
      CharacterIndex.routeName,
      null)
];
