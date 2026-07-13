import 'package:era92_elevate/providers/auth_provider.dart';
import 'package:era92_elevate/screens/auth_screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await context.read<AuthProvider>().logout();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: Text(user?.fullName ?? 'Admin Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Log out',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Signed in as ${user?.email ?? 'Admin'}'),
      ),
    );
  }
}
