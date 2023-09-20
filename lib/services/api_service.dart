import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chat_gpt/constants/api_consts.dart';
import 'package:http/http.dart' as http;

import '../models/cahat_models.dart';
import '../models/models_model.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/models'),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );
      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        print(jsonResponse['error']['message']);
        throw HttpException(jsonResponse['error']['message']);
      }

      // print(jsonResponse);
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      log('error $e');
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      final response = await http.post(Uri.parse('$BASE_URL/chat/completions'),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'model': modelId,
            'messages': [
              {'role': 'user', 'content': message}
            ],
            'temperature': 0.7,
          }));
      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            chatIndex: 1,
            msg: jsonResponse['choices'][index]['message']['content'],
          ),
        );
      }
      return chatList;
    } catch (e) {
      log('error $e');
      rethrow;
    }
  }
}
