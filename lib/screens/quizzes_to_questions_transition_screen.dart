import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class QuizzesToQuestionsTransitionScreen extends StatefulWidget {
  const QuizzesToQuestionsTransitionScreen({Key? key}) : super(key: key);

  @override
  State<QuizzesToQuestionsTransitionScreen> createState() =>
      _QuizzesToQuestionsTransitionScreenState();
}

class _QuizzesToQuestionsTransitionScreenState
    extends State<QuizzesToQuestionsTransitionScreen> {
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
      () => Navigator.of(context).pushReplacementNamed(
        utils.questionsScreenRoute,
      ),
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
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Card(
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
                              width:
                                  utils.veryLargePadding + utils.largePadding,
                              child: Divider(
                                color: Theme.of(context).primaryColorLight,
                                height: utils.tinyPadding,
                                thickness: utils.tinyPadding,
                              ),
                            ),
                            const SizedBox(
                              height:
                                  utils.extraLargePadding + utils.largePadding,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topCenter,
                              children: [
                                Positioned(
                                  top: -utils.extraLargePadding,
                                  child: BlocBuilder<ChildDetailsOpsCubit,
                                      ChildDetailsOpsState>(
                                    builder: (_, childDetailsOpsState) =>
                                        RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: (utils.largePadding +
                                                  utils.padding) -
                                              utils.tinyPadding,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: utils.passYourText,
                                          ),
                                          const TextSpan(
                                            text: utils.newLineText,
                                          ),
                                          const TextSpan(
                                            text: utils.phoneToText,
                                          ),
                                          const TextSpan(
                                            text: utils.newLineText,
                                          ),
                                          TextSpan(
                                            text: childDetailsOpsState
                                                    is GotChildDetailsState
                                                ? childDetailsOpsState.child
                                                    .data()!
                                                    .name
                                                : utils.emptyStringText,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Image(
                                  image: utils.holdingPhoneImage,
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
              Positioned(
                top: -utils.smallPadding,
                child: SizedBox(
                  width: utils.largePadding,
                  height: utils.largePadding,
                  child: FloatingActionButton(
                    heroTag: utils.anotherDifferentHeroTagText,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Theme.of(context).primaryColor,
                      size: utils.padding + utils.smallPadding,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
