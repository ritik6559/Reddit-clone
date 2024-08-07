import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_clone/components/snackbar.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/failure.dart';
import 'package:reddit_clone/core/providers/storage_repository.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone/features/community/repository/community_repository.dart';
import 'package:reddit_clone/models/coummunity_model.dart';
import 'package:reddit_clone/models/post_model.dart';
import 'package:routemaster/routemaster.dart';

final userCommunitiesProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getUserCommunities();
});

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRepository = ref.read(communityRepositoryProvider);
  return CommunityController(
      communityRepository: communityRepository,
      ref: ref,
      storageRepository: ref.watch(storageRepositoryProvider));
});

final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(communityControllerProvider.notifier)
      .getCommunityByName(name);
});

final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

final getCommunityPostsProvider = StreamProvider.family((ref,String name)  {
  return ref.read(communityControllerProvider.notifier).getPosts(name);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  CommunityController(
      {required CommunityRepository communityRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _communityRepository = communityRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? ' ';
    Community community = Community(
        name: name,
        id: name,
        avatar: Constants.avatarDefault,
        banner: Constants.bannerDefault,
        members: [uid],
        mods: [uid]);

    final res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, "Community created successfully");
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRepository.getUserCommunities(uid);
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name);
  }

  void editCommunity(
      {required File? profileFile,
      required File? bannerFile,
      required Uint8List? profileWebFile,
      required Uint8List? bannerWebFile,
      required BuildContext context,
      required Community community,
      }) async {
    state =
        true; //state = true is simply to know if we are in loading state or not.
    if (profileFile != null || profileWebFile != null) {
      //it will be stored as communities/profile/file_name.
      //if we change the profile another time it will be overrided.
      final res = await _storageRepository.storeFile(
        path: 'communities/profile',
        id: community.name,
        file: profileFile,
        webFile: profileWebFile,
      );

      res.fold(
          (l) => showSnackBar(context, l.message),
          (r) => community = community.copyWith(
                avatar: r,
              ) //we cannot do community.avatar = r becuase avatar is final therefore we can't change its value.
          );
    }
    if (bannerFile != null || bannerWebFile != null) {
      //it will be stored as communities/banner/file_name.
      //if we change the profile another time it will be overrided.
      final res = await _storageRepository.storeFile(
        path: 'communities/banner',
        id: community.name,
        file: bannerFile,
        webFile: bannerWebFile,
      );

      res.fold(
          (l) => showSnackBar(context, l.message),
          (r) => community = community.copyWith(
                banner: r,
              ) //we cannot do community.avatar = r becuase avatar is final therefore we can't change its value.
          );
    }
    final res = await _communityRepository.editCommunity(community);
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Routemaster.of(context).pop(),
    );
  }

  Stream<List<Community>> searchCommunity(String query) {
    return _communityRepository.searchCommunity(query);
  }

  void joinCommunity(Community communtiy, BuildContext context) async {
    final user = _ref.read(userProvider)!;

    Either<Failure, void> res;
    if (communtiy.members.contains(user.uid)) {
      res = await _communityRepository.leaveCommunity(communtiy.name, user.uid);
    } else {
      res = await _communityRepository.joinCommunity(communtiy.name, user.uid);
    }

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        if (communtiy.members.contains(user.uid)) {
          showSnackBar(context, "Community left successfully!");
        } else {
          showSnackBar(context, "Community joines successfully!");
        }
      },
    );
  }

  void addMods(
      String communityName, List<String> mods, BuildContext context) async {
    final res = await _communityRepository.addMods(communityName, mods);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Routemaster.of(context).pop(),
    );
  }

  Stream<List<Post>> getPosts(String name) {
    return _communityRepository.getPosts(name);
  }
}
