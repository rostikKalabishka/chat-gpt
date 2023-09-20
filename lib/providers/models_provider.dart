import 'package:chat_gpt/models/models_model.dart';
import 'package:flutter/widgets.dart';

import '../services/api_service.dart';

class ModelsProvider extends ChangeNotifier {
  String _currentModels = 'gpt-3.5-turbo';
  String get currentModels => _currentModels;

  void setCurrentModel(String newModel) {
    _currentModels = newModel;
  }

  List<ModelsModel> modelList = [];

  List<ModelsModel> get getModelList => modelList;

  Future<List<ModelsModel>> getAllModelsModel() async {
    modelList = await ApiService.getModels();

    return modelList;
  }
}
