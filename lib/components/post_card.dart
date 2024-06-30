import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/models/post_model.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({
    required this.post,
    super.key,
    });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
