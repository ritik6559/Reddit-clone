import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_clone/components/sigin_button.dart';
import 'package:reddit_clone/core/constants/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Constants.logoPath,
                height: 70,
                width: 70,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Log in to Reddit",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              LoginTile(
                  onTap: () {},
                  text: "Continue with phone number",
                  imagePath: FontAwesomeIcons.mobile),
              const SizedBox(
                height: 10,
              ),
              LoginTile(
                  onTap: () {},
                  text: "Continue with Google",
                  imagePath: FontAwesomeIcons.google),
              const SizedBox(
                height: 10,
              ),
              LoginTile(
                  onTap: () {},
                  text: "Use email or password",
                  imagePath: FontAwesomeIcons.user),
              const Spacer(),
              Column(
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
