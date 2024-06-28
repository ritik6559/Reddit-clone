import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/components/error_txt.dart';
import 'package:reddit_clone/components/loader.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({required this.uid, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getUserDataProvider(uid)).when(
          data: (user) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 250,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            user.banner,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding:
                              const EdgeInsets.all(20).copyWith(bottom: 70),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePicture),
                            radius: 35,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding:
                              const EdgeInsets.all(20).copyWith(bottom: 70),
                          child: OutlinedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                            ),
                            child: Text(
                              "Edit profile",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "u/${user.name}",
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("${user.karma} karma"),
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: 2),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Container()),
          error: (error, stackTrace) {
            return ErrorText(error: error.toString());
          },
          loading: () => const Loader()),
    );
  }
}
