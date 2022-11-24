import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/utils.dart' as utils;

class QuestionsToQuizzesTransitionScreen extends StatefulWidget {
  const QuestionsToQuizzesTransitionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsToQuizzesTransitionScreen> createState() =>
      _QuestionsToQuizzesTransitionScreenState();
}

class _QuestionsToQuizzesTransitionScreenState
    extends State<QuestionsToQuizzesTransitionScreen> {
  @override
  void initState() {
    _delay();

    super.initState();
  }

  void _delay() async {
    await Future.delayed(
      Duration(
        seconds: utils.tinyPadding.toInt() + utils.veryTinyPadding.toInt(),
      ),
      () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: utils.largePadding,
            horizontal: utils.padding,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(
                utils.padding,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          utils.instructionText,
                          style: TextStyle(
                            fontSize: (utils.padding + utils.smallPadding) -
                                utils.veryTinyPadding,
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: utils.padding,
                        ),
                        SizedBox(
                          width: utils.veryLargePadding + utils.largePadding,
                          child: Divider(
                            color: Theme.of(context).primaryColorLight,
                            height: utils.tinyPadding,
                            thickness: utils.tinyPadding,
                          ),
                        ),
                        const SizedBox(
                          height:
                              utils.extraLargePadding + utils.veryLargePadding,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              top:
                                  -utils.extraLargePadding - utils.largePadding,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize:
                                        (utils.largePadding + utils.padding) -
                                            utils.tinyPadding,
                                    color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: utils.passTheText,
                                    ),
                                    TextSpan(
                                      text: utils.newLineText,
                                    ),
                                    TextSpan(
                                      text: utils.phoneToText,
                                    ),
                                    TextSpan(
                                      text: utils.newLineText,
                                    ),
                                    TextSpan(
                                      text: utils.yourText,
                                    ),
                                    TextSpan(
                                      text: utils.newLineText,
                                    ),
                                    TextSpan(
                                      text: utils.parentText,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Image(
                              image: utils.holdingPhoneTwoImage,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
