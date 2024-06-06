import 'package:flutter/material.dart';

class MenuAtas extends StatelessWidget {
  final IconData menuAtas;

  const MenuAtas({
    Key? key,
    required this.menuAtas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 140.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(25),
        child: Center(
          child: Icon(
            menuAtas,
            size: 50,
            color: Color.fromARGB(255, 66, 50, 97),
          ),
        ),
      ),
    );
  }
}
