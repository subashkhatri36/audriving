import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'package:driveaustralia/widgets/DrivingPage.dart';
import 'package:driveaustralia/widgets/animation_widget.dart';
import 'package:driveaustralia/widgets/question_answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatefulWidget {
  final String? id;
  final String? category;
  final String lastPath;
  final String isTest;
  final String isPractiseOrTest;

  const TestPage({
    Key? key,
    this.id,
    this.category,
    required this.lastPath,
    required this.isPractiseOrTest,
    required this.isTest,
  }) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    if (widget.isTest == '1') {
      context.read<DktBloc>().add(StartTestEvent(widget.category ?? '', 0));
    } else {
      context.read<DktBloc>().add(StartPractiseEvent(widget.category ?? '', 0));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context
        .watch<DktBloc>()
        .state;

    return DrivingPage(
      lastpath: widget.lastPath,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: BackButton(
          onPressed: () => context.go(widget.lastPath),
        ),
        title: Text(widget.category ?? ''),
      ),
      body: state.loadingvalue
          ? const Text('Loading...')
          : FadeTransactionWidget(
        child: ShowQuestionAnswer(
          model: state.model ??
              DktModel(
                  question: '',
                  image: '',
                  options: [],
                  correct: 0,
                  category: ''),
          practiseOrTest: widget.isPractiseOrTest == '0' ? false : true,
          index: state.index,
          isTest: widget.isTest == '0' ? false : true,
          lastPath: widget.lastPath,
          totalQuestion: state.modelList?.length ?? 0,
        ),
      ),
    );
  }
}
