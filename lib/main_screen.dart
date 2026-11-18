import 'package:flutter/material.dart';
import 'demo_auth.dart';
import 'dashboard_page.dart';
import 'calculator_screen.dart';
import 'profile_page.dart';
import 'social_media/social_media.dart';

// The main screen with a navigation bar that switches between four pages.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// State for MainScreen. Tracks the selected tab and holds the four pages.
class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  // The four pages of the app. IndexedStack keeps every page alive so each
  // page's state is preserved while switching tabs. SocialMediaPage needs the
  // logged-in username, so pages are built in initState after login.
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    // MainScreen must only be opened after a successful login because it reads
    // DemoAuth.currentUsername.
    final username = DemoAuth.currentUsername!;

    // The order of pages must match the order of the navigation destinations.
    pages = [
      DashboardPage(username: username),
      const CalculatorScreen(),
      SocialMediaPage(username: username),
      ProfilePage(username: username),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps every page mounted, so Calculator inputs and Social
      // posts, likes and comments are preserved while switching tabs.
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Social',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
