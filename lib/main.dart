import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/nav_items.dart';
import 'package:note_taking_app/constants/strings.dart';
import 'package:note_taking_app/constants/theme.dart';
import 'package:note_taking_app/view_model/note_view_model.dart';
import 'package:provider/provider.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _screenOptions =
      kNavItems.map((navItem) => navItem.screen).toList();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: NoteViewModel()),
      ],
      child: MaterialApp(
        title: kAppName,
        theme: kThemeData,
        home: Scaffold(
          body: _screenOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: kNavItems
                .map(
                  (navItem) => BottomNavigationBarItem(
                    icon: Icon(navItem.iconData),
                    label: navItem.label,
                  ),
                )
                .toList(),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
