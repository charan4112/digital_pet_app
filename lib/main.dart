import 'package:flutter/material.dart';

void main() {
  runApp(DigitalPetApp());
}

class DigitalPetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4, // 4 tabs
        child: PetTabsScreen(),
      ),
    );
  }
}

class PetTabsScreen extends StatefulWidget {
  @override
  _PetTabsScreenState createState() => _PetTabsScreenState();
}

class _PetTabsScreenState extends State<PetTabsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Digital Pet App"),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "Pet Info"),
              Tab(text: "Pet Image"),
              Tab(text: "Actions"),
              Tab(text: "Activity Log"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Pet Info Tab
            Center(
              child: Text(
                "Name: Fluffy\nHappiness: 80%\nHunger: 40%",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            // Pet Image Tab
            Center(
              child: Image.network(
                'https://example.com/pet_image.png', // Replace with actual image URL
                width: 150,
                height: 150,
              ),
            ),

            // Actions Tab (Play & Feed Buttons)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You played with your pet!')),
                      );
                    },
                    child: Text("Play with Pet"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You fed your pet!')),
                      );
                    },
                    child: Text("Feed Pet"),
                  ),
                ],
              ),
            ),

            // Activity Log Tab (ListView)
            ListView(
              children: [
                ListTile(title: Text('Fed Pet at 10:00 AM')),
                ListTile(title: Text('Played with Pet at 12:00 PM')),
              ],
            ),
          ],
        ),
        a);
  }
}
