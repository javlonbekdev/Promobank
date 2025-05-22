import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget buildNavItem(IconData icon, int index) {
    final isSelected = index == _selectedIndex;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: isSelected ? 1.0 : 1.0, end: isSelected ? 1.4 : 1.0),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: IconButton(
            icon: Icon(icon,
                color: isSelected ? Colors.red : Colors.grey),
            onPressed: () => _onTabTapped(index),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Selected: $_selectedIndex", style: TextStyle(fontSize: 24))),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.grid_view, 0),
              buildNavItem(Icons.list, 1),
              SizedBox(width: 40), // FAB joyi
              buildNavItem(Icons.wallet, 3),
              buildNavItem(Icons.person, 4),
            ],
          ),
        ),
      ),
      floatingActionButton: TweenAnimationBuilder<double>(
        tween: Tween<double>(
            begin: _selectedIndex == 2 ? 1.0 : 1.0,
            end: _selectedIndex == 2 ? 1.4 : 1.0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: FloatingActionButton(
              onPressed: () => _onTabTapped(2),
              backgroundColor: Colors.white,
              child: Icon(Icons.swap_horiz,
                  color: _selectedIndex == 2 ? Colors.red : Colors.grey),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}