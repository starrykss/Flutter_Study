import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:section_09/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true, // 내림차순 정렬 (최근 메시지가 위에 위치)
          )
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // 데이터가 없을 경우
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found.'),
          );
        }

        // 에러가 발생할 경우
        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        final loadedMessages = chatSnapshots.data!.docs;

        // 채팅 메시지 표시
        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse: true, // 최근메시지가 아래에 위치하도록 설정
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            // 메시지 아이템
            final chatMessage = loadedMessages[index].data();

            // 다음 메시지
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;

            // 현재 메시지 사용자ID
            final currentMessageUserId = chatMessage['userId'];

            // 다음 메시지 사용자ID
            final nextMessageUserId = nextChatMessage != null
                ? nextChatMessage['userId']
                : null;

            // 다음 사용자가 동일한 경우
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            // Case 1) 현재 메시지 작성자와 다음 메시지 작성자가 동일한 경우
            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
            // Case 2) 현재 메시지 작성자와 다음 메시지 작성자가 동일하지 않은 경우
            else {
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
          },
        );
      },
    );
  }
}
