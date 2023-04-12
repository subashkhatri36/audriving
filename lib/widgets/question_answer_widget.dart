import 'package:driveaustralia/ads/banner.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'package:driveaustralia/widgets/dkt_space.dart';
import 'package:flutter/material.dart';

Widget showQuestionAnswer({
  required DktModel model,
  required bool practiseOrTest,
  required int index,
  required BuildContext context,
  Color? textColor,
  Color? backgroundColor,
}) {
  return practiseOrTest
      ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DktSpace(),
            Text(
              ' ${model.question}',
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            if (model.image.isNotEmpty)
              const DktSpace(
                height: 10,
              ),
            model.image.isNotEmpty
                ? Image.asset(
                    model.image,
                    width: MediaQuery.of(context).size.height * 0.15,
                  )
                : const SizedBox(),
            if (model.image.isNotEmpty)
              const DktSpace(
                height: 10,
              ),
            const AdmobBannerAdWidget(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: model.options.length,
                itemBuilder: (context, idx) {
                  final e = model.options[idx];
                  return InkWell(
                    onTap: () {},
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
                          e.sno == model.correct
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              e.option,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: textColor ?? Colors.black,
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
            Container()
          ],
        )
      : ListTile(
          title: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                '${(index + 1)}. ${model.question}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              if (model.image.isNotEmpty)
                const DktSpace(
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
                      (e) => InkWell(
                        onTap: practiseOrTest ? () {} : null,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: e.sno == model.correct
                                            ? Colors.green
                                            : Colors.red),
                              )),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                if (!practiseOrTest) const Divider(),
              ]),
        );
}
