import 'package:chat_gpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';

Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);

List<String> models = [
  'Model1',
  'Model2',
  'Model3',
  'Model4',
  'Model5',
  'Model6',
];

List<DropdownMenuItem<String?>>? get getModelsItem {
  List<DropdownMenuItem<String?>>? modelsItem =
      List<DropdownMenuItem<String?>>.generate(
    models.length,
    (index) => DropdownMenuItem(
      value: models[index],
      child: TextWidget(
        label: models[index],
        fontSize: 15,
      ),
    ),
  );
  return modelsItem;
}

final chatMessages = [
  {'message': 'Hello who are you', 'chatIndex': 0},
  {'message': 'Hello, i am ChatGPT', 'chatIndex': 1},
  {'message': 'What is flutter?', 'chatIndex': 0},
  {
    'message': 'Flutter is open-source mobile application dev framework',
    'chatIndex': 1
  },
  {'message': 'Hello who are you', 'chatIndex': 0},
  {'message': 'Hello, i am ChatGPT', 'chatIndex': 1},
  {'message': 'What is flutter?', 'chatIndex': 0},
  {
    'message': 'Flutter is open-source mobile application dev framework',
    'chatIndex': 1
  },
];
