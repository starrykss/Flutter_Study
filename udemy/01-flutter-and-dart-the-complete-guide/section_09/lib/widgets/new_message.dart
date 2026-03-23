import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // 🔵 메시지 보내기 이벤트 처리
  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    // 메시지 내용이 없을 경우
    if (enteredMessage.trim().isEmpty) {
      return;
    }

    // 포커스 해제 (입력 키보드 가리기)
    FocusScope.of(context).unfocus();

    // 내용 비우기
    _messageController.clear();

    // Firebase에 전송하기
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final userDataMap = userData.data() ?? {};
    final username =
        (userDataMap['username'] as String?) ??
        user.displayName ??
        user.email ??
        'Unknown user';
    final rawUserImage =
        (userDataMap['image_url'] as String?) ?? user.photoURL;
    final userImage =
        rawUserImage != null && rawUserImage.isNotEmpty ? rawUserImage : null;

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': username,
      'userImage': userImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 1,
        bottom: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.send),
            onPressed: _submitMessage,
          ),
        ],
      ),
    );
  }
}
