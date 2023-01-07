
import 'package:flutter/material.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';

class AppBar extends StatelessWidget {
  const AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Auth.isGuestLoggedIn ? 
            Text("guest"):
            Text(Auth.getFullName ?? ""),
          ],
        )
      ],
    );
  }
}