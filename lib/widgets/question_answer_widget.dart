import 'package:driveaustralia/bloc/model/models.dart';
import 'package:flutter/material.dart';

Widget showQuestionAnswer(
    {required DktModel model,
    required bool practiseOrTest,
    required int index,
    required BuildContext context}) {
  return ListTile(
    title: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          '${(index + 1)}. ${model.question}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
          textAlign: TextAlign.justify,
        ),
        if (model.image.isNotEmpty)
          const SizedBox(
            height: 10,
          ),
        model.image.isNotEmpty
            ? Image.asset(
                model.image,
                width: MediaQuery.of(context).size.height * 0.15,
              )
            : const SizedBox(),
      ],
    ),
    isThreeLine: true,
    subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...model.options
              .map(
                (e) => Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: e.sno == model.correct
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                      ),
                      Expanded(
                          child: Text(
                        e.option,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: e.sno == model.correct
                                ? Colors.green
                                : Colors.red),
                      )),
                    ],
                  ),
                ),
              )
              .toList(),
          const Divider(),
        ]),
  );
}
