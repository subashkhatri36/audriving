import 'package:driveaustralia/ads/banner.dart';
import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'package:driveaustralia/widgets/dkt_button.dart';
import 'package:driveaustralia/widgets/dkt_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowQuestionAnswer extends StatefulWidget {
  final DktModel model;
  final bool practiseOrTest;
  final int index;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isTest;

  const ShowQuestionAnswer({
    Key? key,
    required this.model,
    required this.practiseOrTest,
    required this.index,
    this.textColor,
    this.backgroundColor,
    this.isTest = false,
  }) : super(key: key);

  @override
  State<ShowQuestionAnswer> createState() => _ShowQuestionAnswerState();
}

class _ShowQuestionAnswerState extends State<ShowQuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return widget.practiseOrTest
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DktSpace(),
              Text(
                widget.model.question,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              if (widget.model.image.isNotEmpty)
                const DktSpace(
                  height: 10,
                ),
              widget.model.image.isNotEmpty
                  ? Image.asset(
                      widget.model.image,
                      width: MediaQuery.of(context).size.height * 0.15,
                    )
                  : const SizedBox(),
              if (widget.model.image.isNotEmpty)
                const DktSpace(
                  height: 10,
                ),
              const AdmobBannerAdWidget(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.model.options.length,
                  itemBuilder: (context, idx) {
                    final e = widget.model.options[idx];
                    return InkWell(
                      onTap: () {
                        context.read<DktBloc>().add(SelectAnswerEvent(
                            selectedIndex: e.sno, index: widget.index));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Row(
                          children: [
                            ///Here is the logic for
                            if (widget.model.selectCorrect != null &&
                                !widget.isTest)
                              e.sno == widget.model.selectCorrect
                                  ? widget.model.selectCorrect ==
                                          widget.model.correct
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        )
                                  : const SizedBox(),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                e?.option ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: widget.textColor ?? Colors.black,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const DktSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // if (!widget.isTest && widget.index != 0)
                  //   DktButton(
                  //     text: 'Previous',
                  //     onPressed: () {},
                  //   ),
                  DktButton(
                    text: 'Next',
                    onPressed: () {
                      if (widget.model.selectCorrect != null) {
                        context
                            .read<DktBloc>()
                            .add(NextQuestion(widget.index + 1));
                      }
                    },
                  ),
                ],
              )
            ],
          )
        : ListTile(
            title: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${(widget.index + 1)}. ${widget.model.question}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                if (widget.model.image.isNotEmpty)
                  const DktSpace(
                    height: 10,
                  ),
                widget.model.image.isNotEmpty
                    ? Image.asset(
                        widget.model.image,
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
                  ...widget.model.options
                      .map(
                        (e) => InkWell(
                          onTap: widget.practiseOrTest ? () {} : null,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: e.sno == widget.model.correct
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: e.sno == widget.model.correct
                                              ? Colors.green
                                              : Colors.red),
                                )),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  if (!widget.practiseOrTest) const Divider(),
                ]),
          );
  }
}
