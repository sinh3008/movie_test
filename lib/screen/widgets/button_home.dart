import 'package:flutter/material.dart';
import 'package:movie_test/screen/loading_screen.dart';

import '../popular_list_screen.dart';

GestureDetector buildGestureDetector(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoadingScreen(),
        ),
      );
    },
    child: Container(
      width: 325,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Popular list',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    ),
  );
}
