import 'package:driveaustralia/ads/ads_controller.dart';
import 'package:driveaustralia/ads/banner.dart';
import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'package:driveaustralia/widgets/animation_widget.dart';
import 'package:driveaustralia/widgets/dkt_button.dart';
import 'package:driveaustralia/widgets/dkt_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ShowQuestionAnswer extends StatefulWidget {
  final DktModel model;
  final bool practiseOrTest;
  final int index;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isTest;
  final String lastPath;
  final int totalQuestion;

  const ShowQuestionAnswer({
    Key? key,
    required this.model,
    required this.practiseOrTest,
    required this.index,
    this.textColor,
    this.backgroundColor,
    this.isTest = false,
    required this.lastPath,
    required this.totalQuestion,
  }) : super(key: key);

  @override
  State<ShowQuestionAnswer> createState() => _ShowQuestionAnswerState();
}

class _ShowQuestionAnswerState extends State<ShowQuestionAnswer> {
  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  showToast() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.warning,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Please Select listed Options",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int v = widget.index >= 5 ? (widget.index / 5).round() : 1;
    return FadeTransactionWidget(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: widget.practiseOrTest
              ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DktSpace(),
              Text(
                '${widget.index + 1}) ${widget.model.question}',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              if (widget.isTest)
                const DktSpace(
                  height: 10,
                ),
              if (widget.isTest)
                Text(
                  '(${widget.model.category})',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 16, color: Colors.grey),
                ),
              if (widget.isTest)
                const DktSpace(
                  height: 10,
                ),
              if (widget.model.image.isNotEmpty)
                const DktSpace(
                  height: 10,
                ),
              widget.model.image.isNotEmpty
                  ? Image.asset(
                widget.model.image,
                width: MediaQuery
                    .of(context)
                    .size
                    .height * 0.15,
              )
                  : const SizedBox(
                height: 10,
              ),
              if (widget.model.image.isNotEmpty)
                const DktSpace(
                  height: 10,
                ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.model.options.length,
                itemBuilder: (context, idx) {
                  final e = widget.model.options[idx];
                  return FadeTransactionWidget(
                    child: InkWell(
                      onTap: () {
                        context.read<DktBloc>().add(SelectAnswerEvent(
                            selectedIndex: e.sno, index: widget.index));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.isTest
                                ? e.sno == widget.model.selectCorrect
                                ? Colors.blue.shade400
                                : null
                                : null,
                            border: widget.isTest
                                ? e.sno == widget.model.selectCorrect
                                ? Border.all(
                                color: Colors.blue.shade400)
                                : Border.all()
                                : Border.all(),
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 12),
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
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  color: widget.isTest
                                      ? e.sno ==
                                      widget
                                          .model.selectCorrect
                                      ? Colors.white
                                      : widget.textColor ??
                                      Colors.black
                                      : widget.textColor ??
                                      Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const AdmobBannerAdWidget(),
              const DktSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.isTest && widget.index != 0)
                    DktButton(
                      color: Colors.blue.shade600,
                      text: 'Previous',
                      onPressed: () {
                        int nextInt = widget.index - 1;
                        context.read<DktBloc>().add(PreviousEvent(
                            index: nextInt, isTest: widget.isTest));
                      },
                    ),
                  (widget.index + 1) >= widget.totalQuestion &&
                      !widget.isTest
                      ? DktButton(
                    text: 'Exit',
                    onPressed: () {
                      AdmobController().showInstAds();
                      context.go(widget.lastPath);
                    },
                  )
                      : (widget.index + 1) >= widget.totalQuestion &&
                      widget.isTest
                      ? DktButton(
                    color: Colors.green,
                    text: 'Show Result',
                    onPressed: () {
                      AdmobController().loadInterstitialAd();

                      AdmobController().showInstAds();
                      context.goNamed('showresult', params: {
                        'lastPath': widget.lastPath
                      });
                    },
                  )
                      : DktButton(
                    color: Colors.blue.shade800,
                    text: 'Next',
                    onPressed: () {
                      if (widget.model.selectCorrect != null ||
                          widget.isTest) {
                        int nextInt = widget.index + 1;
                        context.read<DktBloc>().add(
                            NextQuestion(
                                nextInt, widget.isTest));
                      } else {
                        //Here goes toast/
                        fToast.showToast(
                          child: showToast(),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration:
                          const Duration(seconds: 2),
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          )
              : ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${(widget.index + 1)}. ${widget.model.question}',
                  style: Theme
                      .of(context)
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .height * 0.15,
                )
                    : const SizedBox(
                  height: 5,
                ),
              ],
            ),
            isThreeLine: true,
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.model.options
                      .map(
                        (e) =>
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          margin: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2),
                                child: e.sno == widget.model.correct
                                    ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 15,
                                )
                                    : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 15,
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                    e.option,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                        color:
                                        e.sno == widget.model.correct
                                            ? Colors.green
                                            : Colors.red),
                                  )),
                            ],
                          ),
                        ),
                  )
                      .toList(),
                  if (widget.index == (5 * v))
                    const AdmobBannerAdWidget(),
                  if (!widget.practiseOrTest) const Divider(),
                ]),
          )),
    );
  }
}
