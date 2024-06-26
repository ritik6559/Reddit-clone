//logged out route

//logged in route

import 'package:flutter/material.dart';
import 'package:reddit_clone/features/auth/screen/login_screen.dart';
import 'package:reddit_clone/features/community/screens/community_screen.dart';
import 'package:reddit_clone/features/community/screens/create_community_screen.dart';
import 'package:reddit_clone/features/community/screens/mod_tools_screen.dart';
import 'package:reddit_clone/features/home/screen/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  //HomeScreen and createCommunityScreen routes are fixed routes.
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  //since community screen will not be a fixed route we will use slightly diff method.
  '/r/:name': (route) => MaterialPage(child: CommunityScreen(
    name: route.pathParameters['name']!,
  )),
  '/mod-tools': (_) => const MaterialPage(child: ModToolsScreen()),
});

