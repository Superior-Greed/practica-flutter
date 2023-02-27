import 'package:flutter/material.dart';

import '../routes/routes.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://media.vandalsports.com/i/640x360/5-2022/202251816546_1.jpg"),
                    fit: BoxFit.fill)),
            child: Text(
              'Api tipica de rick and morty',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.limeAccent,
                  fontStyle: FontStyle.italic,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1, 2),
                      blurRadius: 4.0,
                      color: Colors.black,
                    ),
                  ]),
            ),
          ),
          for (var element in routesMenu) ...[
            ListTile(
              title: Text(element.name, style: const TextStyle(fontSize: 20)),
              leading: element.icon,
              onTap: () {
                if (element.arguments != null) {
                  Navigator.pushNamed(context, element.route,
                      arguments: element.arguments);
                } else {
                  Navigator.pushNamed(context, element.route);
                }
              },
            ),
          ]
        ],
      ),
    );
  }
}
