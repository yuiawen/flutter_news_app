import 'package:flutter/material.dart';
import 'guest_profile_screen.dart';
import 'user_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Simulasi status login pengguna
  bool _isLoggedIn = false;

  void _login() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      // Tampilkan halaman yang sesuai berdasarkan status login
      body: _isLoggedIn
          ? UserProfileScreen(onLogout: _logout)
          : GuestProfileScreen(onLogin: _login),
    );
  }
}
