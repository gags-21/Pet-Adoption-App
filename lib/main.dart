import 'package:flutter/material.dart';
import 'package:pet_adoption_app_task/models/constants.dart';
import 'package:pet_adoption_app_task/provider/theme_provider.dart';
import 'package:pet_adoption_app_task/screens/history_page.dart';
import 'package:pet_adoption_app_task/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'provider/pet_details_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider()..initialize(),
          ),
          ChangeNotifierProvider(
            create: (context) => PetDetailsProvider()..initialize(),
          ),
        ],
        builder: (context, snapshot) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: const MyHomePageState(),
          );
        });
  }
}

class MyHomePageState extends StatefulWidget {
  const MyHomePageState({Key? key}) : super(key: key);

  @override
  State<MyHomePageState> createState() => _MyHomePageStateState();
}

class _MyHomePageStateState extends State<MyHomePageState> {
  List screens = [
    HomePage(),
    HistoryPage(),
  ];
  int currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://static.vecteezy.com/system/resources/previews/007/537/995/non_2x/dog-logo-cartoon-cute-pet-smile-puppy-mascot-wear-glasses-on-white-background-vector.jpg'),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.sunny),
            onPressed: () {
              themeProvider.isDarkMode
                  ? // toggle to light : //toggle to dark
                  themeProvider.toggleTheme(false)
                  : themeProvider.toggleTheme(true);
            },
          ),
        ],
        title: const Text('User Name'),
      ),
      body: screens[currentScreen],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: accentColor,
          currentIndex: currentScreen,
          onTap: (int index) {
            setState(() {
              currentScreen = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'History',
              icon: Icon(Icons.history),
            ),
          ],
        ),
      ),
    );
  }
}
