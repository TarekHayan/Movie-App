import 'package:flutter/material.dart';

class AddToFav extends StatefulWidget {
  const AddToFav({super.key});

  @override
  State<AddToFav> createState() => _AddToFavState();
}

class _AddToFavState extends State<AddToFav> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isClick = true;
        });
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          key: ValueKey<bool>(isClick),
          isClick ? Icons.done : Icons.add,
          size: 30,
          color: isClick ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}
