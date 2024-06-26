import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/components/error_txt.dart';
import 'package:reddit_clone/components/loader.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({required this.name, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: AppBar(
              title: const Text("Edit community"),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Save",
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          color: Theme.of(context).colorScheme.inversePrimary,
                          dashPattern: const [10,4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                            child: community.banner.isEmpty ||
                                    community.banner == Constants.bannerDefault
                                ? const Center(
                                    child: Icon(Icons.camera_alt_outlined),
                                  )
                                : Image.network(community.banner),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(community.avatar),
                            radius: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
