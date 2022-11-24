import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(this._id, {Key? key}) : super(key: key);

  final String _id;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  void initState() {
    final childDetailsState =
        BlocProvider.of<ChildDetailsOpsCubit>(context).state;
    if (childDetailsState is GotChildDetailsState) {
      BlocProvider.of<ModuleQuestionsOpsCubit>(context)
          .listenChildModuleQuestionsChanges(
        childId: childDetailsState.child.id,
        moduleId: widget._id,
      );
    }

    super.initState();
  }

  @override
  void deactivate() {
    BlocProvider.of<ModuleQuestionsOpsCubit>(context)
        .stopListeningModuleQuestionsChanges();

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<ChildDetailsOpsCubit, ChildDetailsOpsState>(
          builder:
              (_, childDetailsOpsState) =>
                  childDetailsOpsState is GotChildDetailsState
                      ? BlocBuilder<ModuleQuestionsOpsCubit,
                          ModuleQuestionsOpsState>(
                          builder:
                              (moduleQuestionsOpsContext,
                                      moduleQuestionsOpsState) =>
                                  moduleQuestionsOpsState
                                          is GotModuleQuestionsState
                                      ? Padding(
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    child:
                                                        moduleQuestionsOpsState
                                                                .questions
                                                                .isNotEmpty
                                                            ? Column(
                                                                children: [
                                                                  Expanded(
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount: moduleQuestionsOpsState
                                                                          .questions
                                                                          .length,
                                                                      itemBuilder:
                                                                          (_, index) =>
                                                                              Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          bottom: utils.padding +
                                                                              utils.tinyPadding +
                                                                              utils.tinyPadding,
                                                                        ),
                                                                        child:
                                                                            Card(
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                          shape:
                                                                              const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(
                                                                              Radius.circular(
                                                                                utils.smallPadding + utils.tinyPadding + utils.tinyPadding,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(
                                                                              vertical: utils.padding,
                                                                              horizontal: utils.smallPadding,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  moduleQuestionsOpsState.questions[index].data().question,
                                                                                  style: TextStyle(
                                                                                    fontSize: (utils.padding + utils.smallPadding) - utils.veryTinyPadding,
                                                                                    color: Theme.of(context).primaryColorLight,
                                                                                    fontWeight: FontWeight.w300,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: utils.smallPadding + utils.tinyPadding,
                                                                                ),
                                                                                Row(
                                                                                  children: List<Widget>.generate(
                                                                                    moduleQuestionsOpsState.questions[index].data().options.length,
                                                                                    (innerIndex) => Expanded(
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Radio<int>(
                                                                                            value: moduleQuestionsOpsState.questions[index].data().options.indexOf(
                                                                                                  moduleQuestionsOpsState.questions[index].data().options[innerIndex],
                                                                                                ),
                                                                                            groupValue: moduleQuestionsOpsState.questions[index].data().answer,
                                                                                            onChanged: (value) {
                                                                                              if (value != null) {
                                                                                                moduleQuestionsOpsContext.read<ModuleQuestionsOpsCubit>().answerQuestion(
                                                                                                      childId: childDetailsOpsState.child.id,
                                                                                                      moduleId: widget._id,
                                                                                                      questionId: moduleQuestionsOpsState.questions[index].id,
                                                                                                      answer: value,
                                                                                                    );
                                                                                              }
                                                                                            },
                                                                                          ),
                                                                                          Text(
                                                                                            moduleQuestionsOpsState.questions[index].data().options[innerIndex],
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              fontSize: utils.padding - utils.tinyPadding,
                                                                                              color: Theme.of(context).primaryColorLight,
                                                                                              fontWeight: FontWeight.w300,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: utils
                                                                        .padding,
                                                                  ),
                                                                  ElevatedButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all<
                                                                              Color>(
                                                                        Theme.of(context)
                                                                            .floatingActionButtonTheme
                                                                            .backgroundColor!,
                                                                      ),
                                                                      padding:
                                                                          MaterialStateProperty.all<
                                                                              EdgeInsetsGeometry>(
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                          horizontal:
                                                                              utils.largePadding,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pushReplacementNamed(
                                                                        utils
                                                                            .questionsToQuizzesTransitionScreenRoute,
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      utils
                                                                          .doneText,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            utils.padding -
                                                                                utils.veryTinyPadding,
                                                                        color: Theme.of(context)
                                                                            .primaryColorLight,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .circleQuestion,
                                                                      size: (utils.largePadding +
                                                                              utils.smallPadding) -
                                                                          utils.tinyPadding,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight
                                                                          .withOpacity(
                                                                            utils.nilDotFiveFive,
                                                                          ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: utils
                                                                              .tinyPadding +
                                                                          utils
                                                                              .tinyPadding,
                                                                    ),
                                                                    Text(
                                                                      utils
                                                                          .noAvailableQuestionsForThisModuleText,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            utils.padding +
                                                                                utils.veryTinyPadding,
                                                                        color: Theme.of(context)
                                                                            .primaryColorLight
                                                                            .withOpacity(
                                                                              utils.nilDotFiveFive,
                                                                            ),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    )
                                                                  ],
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
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColorLight,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Icon(
                                                      FontAwesomeIcons
                                                          .arrowLeft,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      size: utils.padding +
                                                          utils.smallPadding,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
        ),
      );
}
