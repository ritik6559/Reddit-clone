import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/components/error_txt.dart';
import 'package:reddit_clone/components/loader.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:reddit_clone/features/posts/controller/post_controller.dart';
import 'package:reddit_clone/models/post_model.dart';
import 'package:reddit_clone/responsive/responsive.dart';
import 'package:reddit_clone/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({
    required this.post,
    super.key,
  });

  void deletePost(WidgetRef ref, BuildContext context) async {
    ref.read(postControllerProvider.notifier).deletPost(post, context);
  }

  void upVotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).upvote(post);
  }

  void downVotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).downvote(post);
  }

  void navigateToUser(BuildContext context) {
    Routemaster.of(context).push('/u/${post.uid}');
  }

  void navigateToCommunity(BuildContext context) {
    Routemaster.of(context).push('/r/${post.communityName}');
  }

  void navigateToCommentsScreen(BuildContext context) {
    Routemaster.of(context).push('/post/${post.id}/comments');
  }

  void awardPost(WidgetRef ref, String award, BuildContext context) async {
    ref
        .read(postControllerProvider.notifier)
        .awardPost(post: post, award: award, context: context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeImage = post.type == 'image';
    final isTypeText = post.type == 'text';
    final isTypeLink = post.type == 'link';

    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    return Responsive(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (kIsWeb)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => upVotePost(ref),
                        icon: Icon(
                          Constants.up,
                          size: 30,
                          color: post.upvotes.contains(user.uid)
                              ? Pallete.redColor
                              : null,
                        ),
                      ),
                      Text(
                        '${post.upvotes.length - post.downvotes.length == 0 ? 'Vote' : post.upvotes.length - post.downvotes.length}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      IconButton(
                        onPressed: () => downVotePost(ref),
                        icon: Icon(
                          Constants.down,
                          size: 30,
                          color: post.downvotes.contains(user.uid)
                              ? Pallete.blueColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ).copyWith(right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => navigateToCommunity(context),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            post.communityProfilePic),
                                        radius: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'r/${post.communityName}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                navigateToUser(context),
                                            child: Text(
                                              'r/${post.username}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (post.uid == user.uid)
                                  IconButton(
                                    onPressed: () => deletePost(ref, context),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Pallete.redColor,
                                    ),
                                  ),
                              ],
                            ),
                            if (post.awards.isNotEmpty) ...[
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: post.awards.length,
                                  itemBuilder: (context, index) {
                                    return Image.asset(
                                      Constants.awards[post.awards[index]]!,
                                      height: 23,
                                    );
                                  },
                                ),
                              ),
                            ],
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                post.title,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (isTypeImage)
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: double.infinity,
                                child: Image.network(
                                  post.link!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            if (isTypeLink)
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: AnyLinkPreview(
                                  displayDirection:
                                      UIDirection.uiDirectionHorizontal,
                                  link: post.link!,
                                ),
                              ),
                            if (isTypeText)
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  post.description!,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            if (!isGuest)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (!kIsWeb)
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () => upVotePost(ref),
                                          icon: Icon(
                                            Constants.up,
                                            size: 30,
                                            color:
                                                post.upvotes.contains(user.uid)
                                                    ? Pallete.redColor
                                                    : null,
                                          ),
                                        ),
                                        Text(
                                          '${post.upvotes.length - post.downvotes.length == 0 ? 'Vote' : post.upvotes.length - post.downvotes.length}',
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        IconButton(
                                          onPressed: () => downVotePost(ref),
                                          icon: Icon(
                                            Constants.down,
                                            size: 30,
                                            color: post.downvotes
                                                    .contains(user.uid)
                                                ? Pallete.blueColor
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            navigateToCommentsScreen(context),
                                        icon: const Icon(
                                          Icons.comment,
                                        ),
                                      ),
                                      Text(
                                        '${post.commentCount == 0 ? 'Comment' : post.commentCount}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  ref
                                      .watch(getCommunityByNameProvider(
                                          post.communityName))
                                      .when(
                                        data: (data) {
                                          if (data.mods.contains(user.uid)) {
                                            return IconButton(
                                              onPressed: () =>
                                                  deletePost(ref, context),
                                              icon: const Icon(
                                                Icons.admin_panel_settings,
                                              ),
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                        error: (error, stackTrace) =>
                                            ErrorText(error: error.toString()),
                                        loading: () => const Loader(),
                                      ),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                  ),
                                                  itemCount: user.awards.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final award =
                                                        user.awards[index];
                                                    return GestureDetector(
                                                      onTap: () => awardPost(
                                                          ref, award, context),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Image.asset(
                                                            Constants.awards[
                                                                award]!),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.card_giftcard_outlined))
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
