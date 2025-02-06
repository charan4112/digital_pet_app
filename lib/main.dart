import 'package:flutter/material.dart';

void main() {
  runApp(DigitalPetApp());
}

class DigitalPetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digi  tal Pet',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: PetTabsScreen(),
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
  String petName = "Fluffy";
  int happinessLevel = 80;
  int hungerLevel = 40;

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

  // Method to get Pet Mood
  String _getPetMood() {
    if (happinessLevel > 70) {
      return 'Happy 😊';
    } else if (happinessLevel >= 30) {
      return 'Neutral 😐';
    } else {
      return 'Unhappy 😟';
    }
  }

  // Method to update happiness and hunger
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      hungerLevel = (hungerLevel + 5).clamp(0, 100);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You played with your pet!')),
    );
  }

  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      happinessLevel = (happinessLevel + 5).clamp(0, 100);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You fed your pet!')),
    );
  }

  // UI Components
  Widget _buildStatusBar(
      {required String label, required int value, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $value',
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        SizedBox(height: 4.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 12,
            backgroundColor: Colors.white30,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveButton({
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return GestureDetector(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: TextStyle(fontSize: 16),
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
        backgroundColor: Colors.blueGrey,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Info'),
            Tab(text: 'Image'),
            Tab(text: 'Actions'),
            Tab(text: 'Activity Log'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Pet Info
          Container(
            color: Colors.lightBlue.shade50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Name: $petName",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Mood: ${_getPetMood()}",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16.0),
                  _buildStatusBar(
                      label: 'Happiness Level',
                      value: happinessLevel,
                      color: Colors.green),
                  SizedBox(height: 12.0),
                  _buildStatusBar(
                      label: 'Hunger Level',
                      value: hungerLevel,
                      color: Colors.red),
                ],
              ),
            ),
          ),

          // Tab 2: Pet Image
          Container(
            color: Colors.grey.shade100,
            child: Center(
              child: Image.network(
                'https://example.com/pet_image.png', // Replace with actual image
                width: 150,
                height: 150,
              ),
            ),
          ),

          // Tab 3: Actions
          Container(
            color: Colors.lightGreen.shade50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInteractiveButton(
                      label: 'Play with Pet',
                      onPressed: _playWithPet,
                      color: Colors.blueAccent),
                  SizedBox(height: 16.0),
                  _buildInteractiveButton(
                      label: 'Feed Your Pet',
                      onPressed: _feedPet,
                      color: Colors.orangeAccent),
                ],
              ),
            ),
          ),

          // Tab 4: Activity Log
          Container(
            color: Colors.amber.shade50,
            child: ListView(
              children: [
                ListTile(title: Text('Fed Pet at 10:00 AM')),
                ListTile(title: Text('Played with Pet at 12:00 PM')),
                ListTile(title: Text('Fed Pet at 3:00 PM')),
                ListTile(title: Text('Played with Pet at 5:00 PM')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
