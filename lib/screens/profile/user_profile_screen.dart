// lib/screens/profile/user_profile_screen.dart

import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const UserProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        // --- Bagian Info Pengguna ---
        const CircleAvatar(
          radius: 50,
          // Ganti dengan gambar profil pengguna
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
        ),
        const SizedBox(height: 12),
        const Text(
          'John Doe', // Ganti dengan nama pengguna
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'john.doe@example.com', // Ganti dengan email pengguna
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        const Divider(),
        // --- Bagian Menu ---
        ListTile(
          leading: const Icon(Icons.edit_outlined),
          title: const Text('Edit Profile'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.bookmark_border),
          title: const Text('Saved Articles'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red[700]),
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.red[700]),
          ),
          onTap: onLogout, // Panggil fungsi logout dari parent
        ),
      ],
    );
  }
}
