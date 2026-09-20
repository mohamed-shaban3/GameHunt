import 'package:flutter/material.dart';

class GameCardItem extends StatelessWidget {
  final dynamic game;

  const GameCardItem({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: game['background_image'] != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  game['background_image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(Icons.gamepad, size: 40),
        title: Text(
          game['name'] ?? 'Unknown Game',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Rating: ${game['rating']} ⭐'),
      ),
    );
  }
}