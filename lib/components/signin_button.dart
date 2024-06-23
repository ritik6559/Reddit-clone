import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({
    super.key,
  });

  void signInWithGoogle(WidgetRef ref) {
    ref.read(authControllerProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => signInWithGoogle(ref),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.inversePrimary),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Constants.googlePath,
              height: 30,
            ),
            const Text(
              "Continue with google",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
