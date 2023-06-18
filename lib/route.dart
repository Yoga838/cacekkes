import 'package:flutter/material.dart';

class RoutePage extends StatelessWidget {
  final double latitude;
  final double longitude;

  RoutePage({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: $latitude',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Longitude: $longitude',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
