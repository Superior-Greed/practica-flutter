import 'package:flutter/material.dart';

import '../widget/menu.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Descripcion Api Generica de Rick And Morty"),
          backgroundColor: Colors.lightGreen),
      drawer: const Menu(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Image.network(
                  "https://i.blogs.es/eaf5dd/rick-morty/840_560.jpeg",
                  fit: BoxFit.fill,
                ),
              ),
              RichText(
                text: const TextSpan(
                    text: "Descripcion",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '''\nEn esta aplicacion encontraran la tipica api que todo el mundo a echo de rick y morty solo que esta tendra un crud''',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
