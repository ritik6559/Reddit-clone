import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/components/error_txt.dart';
import 'package:reddit_clone/components/loader.dart';
import 'package:reddit_clone/components/signin_button.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:reddit_clone/models/coummunity_model.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunityScreen(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push('/r/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            isGuest
                ? const SignInButton()
                : ListTile(
                    title: const Text("Create community"),
                    leading: const Icon(Icons.add),
                    onTap: () => navigateToCreateCommunityScreen(context),
                  ),
            if (!isGuest)
              ref.watch(userCommunitiesProvider).when(
                  data: (communities) => Expanded(
                        child: ListView.builder(
                          itemCount: communities.length,
                          itemBuilder: (context, index) {
                            final community = communities[index];
                            return ListTile(
                              title: Text("r/${community.name}"),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(community.avatar),
                              ),
                              onTap: () {
                                navigateToCommunity(context, community);
                              },
                            );
                          },
                        ),
                      ),
                  error: (error, stackTrace) {
                    return ErrorText(error: error.toString());
                  },
                  loading: () => const Loader())
          ],
        ),
      ),
    );
  }
}
