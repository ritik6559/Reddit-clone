
import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String profilePicture;
  final String banner;
  final String uid;
  final bool isAuthenticated; //if guest or not
  final int karma;
  final List<String> awards;

  UserModel({
    required this.name,
    required this.profilePicture,
    required this.banner,
    required this.uid,
    required this.isAuthenticated,
    required this.karma,
    required this.awards,
  });

  UserModel copyWith({
    String? name,
    String? profilePicture,
    String? banner,
    String? uid,
    bool? isAuthenticated,
    int? karma,
    List<String>? awards,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      banner: banner ?? this.banner,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      karma: karma ?? this.karma,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePicture': profilePicture,
      'banner': banner,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'karma': karma,
      'awards': awards,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      banner: map['banner'] ?? '',
      uid: map['uid'] ?? '',
      isAuthenticated: map['isAuthenticated'] ?? false,
      karma: map['karma']?.toInt() ?? 0,
      awards: List<String>.from(map['awards']),
    );
  }


  @override
  String toString() {
    return 'UserModel(name: $name, profilePicture: $profilePicture, banner: $banner, uid: $uid, isAuthenticated: $isAuthenticated, karma: $karma, awards: $awards)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.name == name &&
      other.profilePicture == profilePicture &&
      other.banner == banner &&
      other.uid == uid &&
      other.isAuthenticated == isAuthenticated &&
      other.karma == karma &&
      listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      profilePicture.hashCode ^
      banner.hashCode ^
      uid.hashCode ^
      isAuthenticated.hashCode ^
      karma.hashCode ^
      awards.hashCode;
  }
}
