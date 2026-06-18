import 'package:era92_elevate/componets/my_button.dart';
import 'package:era92_elevate/componets/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://picsum.photos/200/300?random=1',
      'https://picsum.photos/200/400?random=2',
      'https://picsum.photos/200/250?random=3',
      'https://picsum.photos/200/350?random=4',
      'https://picsum.photos/200/300?random=5',
      'https://picsum.photos/200/400?random=6',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 40),
                  child: SizedBox(
                    height: 300,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _gridImage(images[0], height: 160),
                              const SizedBox(height: 4),
                              _gridImage(images[1], height: 136),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            children: [
                              _gridImage(images[2], height: 120),
                              const SizedBox(height: 4),
                              _gridImage(images[3], height: 176),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            children: [
                              _gridImage(images[4], height: 180),
                              const SizedBox(height: 4),
                              _gridImage(images[5], height: 116),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // fade sits on top, aligned to bottom of the Stack
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0),
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding
                        const SizedBox(height: 120),
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontFamily: 'Instrument',
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                            color: const Color.fromARGB(255, 19, 19, 19),
                          ),
                        ),
                        Text(
                          'Era92 Elevate',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            color: const Color.fromARGB(255, 255, 30, 79),
                          ),
                        ),

                        
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyTextfield(label: 'email', icon: Icons.alternate_email, obscuretext: false),
                  const SizedBox(height: 25),
                  MyTextfield(label: 'password', icon: Icons.lock_person_outlined, obscuretext: true),
                  const SizedBox(height: 25),
                  MyButton(
                    text: 'Login',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 100),

                  Padding(
                          padding: const EdgeInsetsGeometry.only(top: 10),
                          child: Center(
                            child: Image.asset(
                              'assets/images/images-removebg-preview.png',
                              height: 60,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridImage(String url, {required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}