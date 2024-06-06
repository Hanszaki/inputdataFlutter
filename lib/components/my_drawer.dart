import 'package:flutter/material.dart';
import 'package:newproject4/components/my_drawer_tile.dart';
import 'package:newproject4/services/Auth/auth_service.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //app logo
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Image.asset(
              'image/allure.png',
              width: 100,
              height: 100,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          //home list tile
          MyDrawerTile(
            icon: Icons.home_filled,
            text: "Home",
            OnTap: () => Navigator.pop(context),
          ),

          //settings list tile
          MyDrawerTile(
              icon: Icons.settings,
              text: "Settings",
              OnTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              }),

          const Spacer(),
          //logout list tile
          MyDrawerTile(
            icon: Icons.logout,
            text: "Logout",
            OnTap: () {
              logout(); // Memanggil fungsi logout di sini
            },
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
