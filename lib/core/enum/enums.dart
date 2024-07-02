enum ThemeMode { light, dark }

enum UserKarma {
  comment(1),//it specifies the points/karma user gets when he perform tasks.
  textPost(2),
  linkPost(3),
  imagePost(3),
  awardPost(5),
  deletePost(-1);

  final int karma;
  const UserKarma(this.karma);
}
