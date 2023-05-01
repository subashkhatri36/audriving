import 'package:driveaustralia/ads/banner.dart';
import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'package:driveaustralia/widgets/DrivingPage.dart';
import 'package:driveaustralia/widgets/animation_widget.dart';
import 'package:driveaustralia/widgets/dkt_button.dart';
import 'package:driveaustralia/widgets/dkt_space.dart';
import 'package:driveaustralia/widgets/exam_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResultPage extends StatefulWidget {
  final String lastPath;

  const ResultPage({
    Key? key,
    required this.lastPath,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    context.read<DktBloc>().add(ShowResult());
    super.initState();
  }

  bool result(List<DktModel> model) {
    int carwrong = 0;
    int drivingwrong = 0;
    int otherwrong = 0;

    for (var m in model) {
      if (m.selectCorrect != m.correct || m.selectCorrect == null) {
        if (m.category.toLowerCase() == 'Car General'.toLowerCase()) {
          carwrong++;
        } else if (m.category.toLowerCase() ==
            'Driving General'.toLowerCase()) {
          drivingwrong++;
        } else {
          otherwrong++;
        }
      }
    }

    return otherwrong > 0
        ? false
        : carwrong > 2 || drivingwrong > 2
            ? false
            : true;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DktBloc>().state;
    final r = result(state.modelList ?? []);
    int v = 1;
    return DrivingPage(
      lastpath: widget.lastPath,
      appBar: null,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/result.jpeg',
                      height: 160,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text(
                    'You Result',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: r ? Colors.green : Colors.red),
                  ),
                  Text(
                    r
                        ? 'Hurrya! You passed this mock test. Please try another set of questions just clicking try again button.'
                        : 'Sorry, You are not able to pass this mock test please try again.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: r ? Colors.green : Colors.red),
                  ),
                ],
              ),
            ),
            const DktSpace(),
            const Divider(),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    if (index == (5 * v)) {
                      v++;
                      return Column(
                        children: const [
                          AdmobBannerAdWidget(),
                          Divider(),
                        ],
                      );
                    } else {
                      return const Divider();
                    }
                  },
                  shrinkWrap: true,
                  itemCount: state.modelList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final model = state.modelList![index];
                    return FadeTransactionWidget(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                '${index + 1}) ${model.question}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            if (model.image.isNotEmpty)
                              Image.asset(
                                model.image,
                                height: 70,
                                fit: BoxFit.fitHeight,
                              ),
                            const DktSpace(),
                            ...model.options.map((e) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    if (e.sno == model.correct)
                                      const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    else if (e.sno != model.correct &&
                                        model.selectCorrect == e.sno)
                                      const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )
                                    else
                                      const SizedBox(
                                        width: 25,
                                      ),
                                    Expanded(
                                        child: Text('${e.sno}. ${e.option}')),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            if (!kIsWeb) const AdmobBannerAdWidget(),
            Row(
              children: [
                ExamButton(
                  id: '0'.toString(),
                  text: 'Try Again',
                  lastPath: widget.lastPath,
                  categoryModel: state.categorys ?? [],
                ),
                DktButton(
                  color: Colors.blue.shade700,
                  text: 'Menu',
                  onPressed: () {
                    context.go('/navigation');
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
