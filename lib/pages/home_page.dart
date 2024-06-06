import 'package:flutter/material.dart';
import 'package:newproject4/components/my_drawer.dart';
import 'package:newproject4/components/my_tabbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4, // jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        drawer: MyDrawer(),
        //pilihan menu
        body: MyTabBar(),
      ),
    );
  }
}
