import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginViewModel>(context).user;

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: user == null
            ? Text('No user data')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.displayName}!'),
            Text('Full Name: ${user.fullName}'),
            Text('Card Number: ${user.cardNum}'),
            Text('Total Money: \$${user.totalMoney.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
