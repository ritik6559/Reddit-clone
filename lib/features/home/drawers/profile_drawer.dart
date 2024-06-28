import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerStatefulWidget {
  const ProfileDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends ConsumerState<ProfileDrawer> {
  void logout(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toogleTheme();
  }


  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicture),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Text(
              "u/${user.name},",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              title: const Text("My Profile"),
              leading: const Icon(Icons.person),
              onTap: () => navigateToUserProfile(context, user.uid),
            ),
            ListTile(
              title: const Text("Log Out"),
              leading: Icon(
                Icons.logout,
                color: Pallete.redColor,
              ),
              onTap: () => logout(ref),
            ),
            ListTile(
              leading: const Text(
                "Dark Mode",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              title: Switch.adaptive(
                value: ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.dark,
                onChanged: (value) => toggleTheme(ref),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
