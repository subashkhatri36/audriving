import 'package:driveaustralia/bloc/model/cateory_model.dart';
import 'package:driveaustralia/widgets/dkt_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamButton extends StatelessWidget {
  final String lastPath;
  final String text;
  final String id;
  final List<CategoryModel> categoryModel;

  const ExamButton({
    Key? key,
    required this.id,
    required this.text,
    required this.lastPath,
    required this.categoryModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DktButton(
      color: Colors.teal,
      text: text,
      onPressed: () {
        //Dialog for Rules

        showDialog(
          context: context,
          builder: (BuildContext context) {
            final style = Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold);
            return AlertDialog(
              title: const Text('Rules'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Category',
                            style: style,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Total Qst ',
                            style: style,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Wrong Qst',
                            style: style,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: categoryModel.length,
                          itemBuilder: (context, index) {
                            final model = categoryModel[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(model.category),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      model.totalQuestions.toString(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 22.0),
                                    child: Text(
                                      model.wrongQuestions.toString(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).goNamed('testpage', params: {
                      'id': id.toString(),
                      'category': 'test',
                      'lastPath': lastPath,
                      'isTest': '1',
                      'isPractiseOrTest': '1',
                    });
                  },
                  child: const Text('ACCEPT'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
