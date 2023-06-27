import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool enableAR = true;

  List<_MenuListItem> menus = [
    _MenuListItem(
      description: 'Simple demonstration of unity with WebF library',
      route: '/simple',
      title: 'Simple Flutter + Unity Demo',
      enableAR: false,
    ),
    _MenuListItem(
      description: 'No interaction of unity flutter library',
      route: '/none',
      title: 'No Interaction Unity Demo',
      enableAR: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu List'),
        actions: [
          Row(
            children: [
              const Text("Enable AR"),
              Checkbox(
                value: enableAR,
                onChanged: (changed) {
                  if (changed != null) {
                    setState(() {
                      enableAR = changed;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: menus.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              title: Text(menus[i].title),
              subtitle: Text(menus[i].description),
              onTap: () {
                Navigator.of(context).pushNamed(
                  menus[i].route,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _MenuListItem {
  final String title;
  final String description;
  final String route;
  final bool enableAR;

  _MenuListItem({
    required this.title,
    required this.description,
    required this.route,
    required this.enableAR,
  });
}
