import 'dart:developer';

import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/models/cahat_models.dart';
import 'package:chat_gpt/services/api_service.dart';
import 'package:chat_gpt/services/assets_manager.dart';
import 'package:chat_gpt/services/services.dart';
import 'package:chat_gpt/widgets/chat_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  final textFieldController = TextEditingController();

  List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelsProvider>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              Services.showModalSheet(context: context);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          )
        ],
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.openAiLogoImage),
        ),
        title: const Text('ChatGPT'),
      ),
      body: Center(
        child: SafeArea(
            child: Column(children: [
          Flexible(
            child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    message: chatList[index].msg,
                    chatIndex: (chatList[index].chatIndex),
                  );
                }),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Color.fromARGB(255, 106, 153, 107),
              size: 18,
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          Material(
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: textFieldController,
                      onSubmitted: (value) async {
                        await sendMessageFCT(model);
                      },
                      decoration: const InputDecoration.collapsed(
                          hintText: 'How can i help you',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await sendMessageFCT(model);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ])),
      ),
    );
  }

  Future<void> sendMessageFCT(ModelsProvider model) async {
    try {
      setState(() {
        _isTyping = true;
      });
      log('request biba');
      log(model.currentModels);
      chatList = await ApiService.sendMessage(
          message: textFieldController.text, modelId: model.currentModels);
      setState(() {});
    } catch (error) {
      log('error: $error');
    } finally {
      _isTyping = false;
    }
  }
}
