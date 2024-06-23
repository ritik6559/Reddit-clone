import 'package:flutter/material.dart';

class LoginTile extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final IconData imagePath;
  const LoginTile({
    super.key,
    required this.onTap,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.inversePrimary
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(imagePath),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
