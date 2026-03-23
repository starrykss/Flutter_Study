import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:section_09/widgets/chat_messages.dart';
import 'package:section_09/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // 🔵 푸시 알림 설정
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    // 권한 요청
    await fcm.requestPermission();

    // ! Topic(주제) 기반 토큰 -> 구독
    // - 이 Topic(주제)를 구독하는 모든 장치에 동시에 푸시 알림 전송 가능
    fcm.subscribeToTopic('chat');

    // ! 개별 장치 기반 토큰
    // - 이 토큰을 DB에 저장해서, 해당 기기에 푸시 알림 전송 가능
    // final token = await fcm.getToken();
    // print(token);
  }

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          // 로그아웃 버튼
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.exit_to_app),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
