import 'package:flutter/material.dart';
import 'package:mentoring/AlbumList/widget/album_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kezdőoldal'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          _HomeNavigationButton(
            label: 'Albumok',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlbumScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HomeNavigationButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _HomeNavigationButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Screen'),
      ),
      body: Center(
        child: const Text('This is another screen.'),
      ),
    );
  }
}
