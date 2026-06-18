import 'package:flutter/material.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:era92_elevate/componets/chat_row.dart';

class StudentsChat extends StatelessWidget {
  const StudentsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded( 
                   child: Text(
                  'Chats',
                  style: TextStyle(
                    fontFamily: 'Instrument',
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    color: const Color.fromARGB(255, 19, 19, 19),
                    letterSpacing: -2.0,
                  ),
                  ),

                  ),

                  Row(children: [
                    Container( 
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                          size: 30,
                        )
                      )
                    ),
                    const SizedBox(width: 20),
                    Container( 
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppGradients.primary,
                      ),
                      child: Center(
                        child: Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        )
                      )
                    ),
                    
                  ],
                  )

                ]
              
              ),
              const SizedBox(height: 40),

              ChartRow(
                initials: 'AB',
                name: 'Alice Brown',
                lastMessage: 'Hurry, he is giving an assignment, now',
                time: '10:30 AM',
                unreadCount: 2,
              ),
               //**
              ChartRow(
                initials: 'CD',
                name: 'Charlie Davis',
                lastMessage: 'What time is class tomorrow?',
                time: '9:15 AM',
                unreadCount: 1,
              ),
              ChartRow(
                initials: 'EF',
                name: 'Emily Foster',
                lastMessage: 'Can you share the notes from today?',
                time: 'Yesterday',
                unreadCount: 0,
              ),
              ChartRow(
                initials: 'GH',
                name: 'George Harris',
                lastMessage: 'I am struggling with the homework.',
                time: 'Monday',
                unreadCount: 0,
              ),
            ],
          ), //**
        ),
      ),
    );
  }
}
