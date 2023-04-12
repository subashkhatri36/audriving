import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/widgets/DrivingPage.dart';
import 'package:driveaustralia/widgets/question_answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatefulWidget {
  final String? id;
  final String? category;
  final String lastPath;

  const TestPage({
    Key? key,
    this.id,
    this.category,
    required this.lastPath,
  }) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    context.read<DktBloc>().add(StartPractiseEvent(widget.category ?? '', 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DktBloc>().state;
    // print('Loading');
    // print(state.loadingvalue);
    // print('Model');
    // print(state.model);
    return DrivingPage(
      lastpath: widget.lastPath,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.go(widget.lastPath),
        ),
      ),
      body: state.loadingvalue
          ? Text('Loaded')
          : showQuestionAnswer(
              model: state.model!,
              practiseOrTest: true,
              index: state.index,
              context: context),
    );
  }
}
