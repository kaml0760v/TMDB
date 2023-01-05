import 'package:flutter/material.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Auth.isGuestLoggedIn
        ? const Text("Please Login with TMDB account to see watch list.")
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
