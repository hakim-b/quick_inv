import 'package:flutter/material.dart';
import 'package:quick_inv/add_items/FirstAddPage.dart';
import 'package:quick_inv/pages/delete_page.dart';

import 'edit_items/FirstUpdatePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickInv',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[WelcomePage(), ActionsPage()][currentPageIdx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIdx,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              selectedIcon: Icon(Icons.home)),
          NavigationDestination(
              icon: Icon(Icons.lock_outline),
              label: "Actions",
              selectedIcon: Icon(Icons.lock)),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIdx = index;
          });
        },
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        SizedBox(height: 50),
        Text(
          "Welcome to QuickInv! 🗄️",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment
              .start, // Align children horizontally at the start
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0), // Add left padding to align with the title
              child: Text(
                "What are you looking for today?",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar(hintText: "Search..."),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Quick Categories",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(children: [
            CategoryCard(categoryName: "Capacitors"),
            CategoryCard(categoryName: "Resistors")
          ]),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text("View all components", style: TextStyle(fontSize: 20)),
          ),
        ),
        Column(
          children: [
            ComponentCard(
                componentName: "Resistor OHM",
                categoryName: "Resistors",
                imgThumbnail: "assets/resist.jpg")
          ],
        )
      ],
    );
  }
}

class ActionsPage extends StatelessWidget {
  const ActionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: FilledButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FirstAddPage()))
                },
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.blue)),
                child: const Row(
                  children: [Text("New Item"), Icon(Icons.add)],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 150,
              child: FilledButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FirstUpdatePage()))
                },
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.green)),
                child: const Row(
                  children: [Text("Update Item"), Icon(Icons.edit)],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 150,
              child: FilledButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeletePage()))
                },
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.red)),
                child: const Row(
                  children: [Text("Delete Item"), Icon(Icons.minimize_rounded)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentCard extends StatelessWidget {
  const ComponentCard(
      {super.key,
      required this.componentName,
      required this.categoryName,
      required this.imgThumbnail});

  final String componentName;
  final String categoryName;
  final String imgThumbnail;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Image(
              image: AssetImage(imgThumbnail),
              height: 100,
              width: 100,
              fit: BoxFit.fitWidth),
          Column(
            children: [
              const Text(
                "Component Name",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(componentName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15))
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              const Text(
                "Category Name",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(categoryName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15))
            ],
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Icon(Icons.abc_sharp),
          ),
        ),
        const SizedBox(height: 8),
        Text(categoryName)
      ],
    );
  }
}
