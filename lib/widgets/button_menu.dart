import 'package:driveaustralia/bloc/model/cateory_model.dart';
import 'package:driveaustralia/widgets/dkt_button.dart';
import 'package:driveaustralia/widgets/exam_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonMenu extends StatelessWidget {
  final BuildContext context;
  final int id;
  final String category;
  final String lastPath;
  final List<CategoryModel> categoryModel;

  const ButtonMenu({
    Key? key,
    required this.context,
    required this.id,
    required this.category,
    required this.lastPath,
    required this.categoryModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            DktButton(
              color: Colors.black38,
              text: 'Start Practise',
              onPressed: () {
                GoRouter.of(context).goNamed('testpage', params: {
                  'id': id.toString(),
                  'category': category,
                  'lastPath': lastPath,
                  'isTest': '0',
                  'isPractiseOrTest': '1',
                });
              },
            ),
            ExamButton(
              id: id.toString(),
              text: 'Start Test',
              lastPath: lastPath,
              categoryModel: categoryModel,
            ),
          ],
        ),
      ),
    );
  }
}
