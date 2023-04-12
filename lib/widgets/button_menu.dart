import 'package:driveaustralia/widgets/dkt_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

Widget buttonMenu({
  required BuildContext context,
  required int id,
  required String category,
  required String lastPath,
}) {
  print('category');
  print(category);
  print('id');
  print(id);
  print('navigation');
  print(lastPath);

  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        DktButton(
          text: 'Start Practise',
          onPressed: () {
            GoRouter.of(context).goNamed('testpage', params: {
              'id': id.toString(),
              'category': category,
              'lastPath': lastPath,
            });
          },
        ),
        DktButton(
          text: 'Start Test',
          onPressed: () {
            GoRouter.of(context).goNamed('testpage', params: {
              'id': id.toString(),
              'category': 'test',
              'lastPath': lastPath,
            });
          },
        )
      ],
    ),
  );
}
