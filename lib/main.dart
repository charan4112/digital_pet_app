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
        length: 4, // We are   adding 4 tabs
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
          Center(child: Text("Pet Information Tab")),
          Center(child: Text("Pet Image Tab")),
          Center(child: Text("Actions Tab")),
          Center(child: Text("Activity Log Tab")),
        ],
      ),
    );
  }
}
