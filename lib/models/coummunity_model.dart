import 'package:flutter/foundation.dart';

class Community {
  final String name;
  final String id;
  final String avatar;
  final String banner;
  final List<String> members;//it contains the uid of all the member of a given community.
  final List<String> mods; //it contains the uid of all the moderators of a given community.
  Community({
    required this.name,
    required this.id,
    required this.avatar,
    required this.banner,
    required this.members,
    required this.mods,
  });

  Community copyWith({
    String? name,
    String? id,
    String? avatar,
    String? banner,
    List<String>? members,
    List<String>? mods,
  }) {
    return Community(
      name: name ?? this.name,
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      banner: banner ?? this.banner,
      members: members ?? this.members,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'avatar': avatar,
      'banner': banner,
      'members': members,
      'mods': mods,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      avatar: map['avatar'] ?? '',
      banner: map['banner'] ?? '',
      members: List<String>.from(map['members']),
      mods: List<String>.from(map['mods']),
    );
  }

  @override
  String toString() {
    return 'Community(name: $name, id: $id, avatar: $avatar, banner: $banner, members: $members, mods: $mods)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Community &&
      other.name == name &&
      other.id == id &&
      other.avatar == avatar &&
      other.banner == banner &&
      listEquals(other.members, members) &&
      listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      id.hashCode ^
      avatar.hashCode ^
      banner.hashCode ^
      members.hashCode ^
      mods.hashCode;
  }
}
