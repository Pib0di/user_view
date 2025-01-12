import 'package:flutter/material.dart';

import '../../../core/model/user_data.dart';

class UserPage extends StatelessWidget {
  static const routeName = '/user';

  const UserPage({super.key, required this.userData});

  final UserData? userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(Icons.person, size: 40)),
            Text('Name: ${userData?.name}'),
            Text('Email: ${userData?.email}'),
            Text('Phone: ${userData?.phone}'),
            Text('Web: ${userData?.company}'),
            Text('Address: ${userData?.address?.city}'),
          ],
        ),
      ),
    );
  }
}
