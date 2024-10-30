import 'package:flutter/material.dart';
import 'music_logic.dart';
import 'package:provider/provider.dart';
import 'package:final_module/final_module/first_screen.dart';

class ApiReadingScreen extends StatelessWidget {
  const ApiReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicLogic>(
      builder: (context, musicLogic, child) {
        if (musicLogic.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: musicLogic.productList.length,
          itemBuilder: (context, index) {
            final item = musicLogic.productList[index];
            return ListTile(
              title: Text(item.status),
              onTap: () {
                // Navigate to detail screen
              },
            );
          },
        );
      },
    );
  }
}
