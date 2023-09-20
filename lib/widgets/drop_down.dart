import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:chat_gpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? currentModels;
  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelsProvider>();
    currentModels = model.currentModels;
    return FutureBuilder<List<ModelsModel>>(
        future: model.getAllModelsModel(),
        builder: (builder, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(
                label: snapshot.error.toString(),
              ),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                      dropdownColor: scaffoldBackgroundColor,
                      iconEnabledColor: Colors.white,
                      items: List<DropdownMenuItem<String?>>.generate(
                        snapshot.data!.length,
                        (index) => DropdownMenuItem(
                          value: snapshot.data![index].id,
                          child: TextWidget(
                            label: snapshot.data![index].id,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      value: currentModels,
                      onChanged: (value) {
                        setState(() {
                          currentModels = value.toString();
                        });
                        model.setCurrentModel(value.toString());
                      }),
                );
        });
  }
}
