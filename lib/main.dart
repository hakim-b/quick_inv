// main.dart
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:quick_inv/models/inventory_item.dart';
import 'package:quick_inv/screens/add_items_screen.dart';
import 'package:quick_inv/screens/edit_items_screen.dart';
import 'package:quick_inv/screens/delete_items_screen.dart';
import 'package:quick_inv/screens/inventory_dashboard.dart';
import 'package:quick_inv/screens/borrowed_items_page.dart';
import 'package:quick_inv/services/oauth.dart';

final pb = PocketBase('https://pbquickinv.happyfir.com');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Inventory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: pb.authStore.isValid ? Future.value(true) : authenticate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == false) {
            return const LoginScreen();
          }
          return const MyHomePage();
        },
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () async {
            final success = await authenticate();
            if (success && context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            }
          },
          child: const Text('Login with Discord'),
        ),
      ),
    );
  }
}

Future<bool> authenticate() async {
  try {
    final result = await authenticateWithPocketBase();
    return result == 'Exec' || result == 'LabSupervisor';
  } catch (e) {
    debugPrint('Authentication error: $e');
    return false;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        InventoryDashboard(pb: pb),
        BorrowedItemsPage(pb: pb),
        const ActionsPage(),
        const WelcomePage(), // Add WelcomePage here for navigation
      ][currentPageIdx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIdx,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
          NavigationDestination(icon: Icon(Icons.swap_horiz_outlined), label: "Borrowed"),
          NavigationDestination(icon: Icon(Icons.build_outlined), label: "Actions"),
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
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

class ActionsPage extends StatelessWidget {
  const ActionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _actionButton(context, "New Item", Icons.add, AddItemScreen()),
            const SizedBox(height: 10),
            _actionButton(
              context,
              "Update Item",
              Icons.edit,
              EditItemScreen(item: InventoryItem(id: '097', dateAdded: DateTime.utc(2025,09,05), partNumber: '12345', type: 'Widget', location: 'A1', quantity: 10)),
            ),
            const SizedBox(height: 10),
            _actionButton(context, "Delete Item", Icons.delete, DeleteItemScreen()),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, String label, IconData icon, Widget screen) {
    return SizedBox(
      width: 150,
      child: FilledButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
        child: Row(children: [Text(label), Icon(icon)]),
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

// Define the WelcomePage here or import it from another file
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0),
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
