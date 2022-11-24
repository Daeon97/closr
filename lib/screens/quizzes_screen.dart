import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class QuizzesScreen extends StatefulWidget {
  const QuizzesScreen({Key? key}) : super(key: key);

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  @override
  void deactivate() {
    BlocProvider.of<ModulesCompletionOpsCubit>(context)
        .stopListeningChildModuleQuestionsAnswerChanges();

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<ModulesToChildOpsCubit, ModulesToChildOpsState>(
          builder: (_, modulesToChildOpsState) =>
              modulesToChildOpsState is GotChildModulesState
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
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      utils.quizzesText,
                                      maxLines: utils.veryTinyPadding.toInt(),
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontSize: utils.largePadding +
                                            utils.tinyPadding,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(
                                      child:
                                          modulesToChildOpsState
                                                  .modules.isNotEmpty
                                              ? ListView.builder(
                                                  itemCount:
                                                      modulesToChildOpsState
                                                          .modules.length,
                                                  itemBuilder: (_, index) {
                                                    final childDetailsState =
                                                        BlocProvider.of<
                                                                    ChildDetailsOpsCubit>(
                                                                context)
                                                            .state;
                                                    if (childDetailsState
                                                        is GotChildDetailsState) {
                                                      BlocProvider.of<
                                                                  ModulesCompletionOpsCubit>(
                                                              context)
                                                          .listenChildModuleQuestionsAnswerChanges(
                                                        childId:
                                                            childDetailsState
                                                                .child.id,
                                                        moduleId:
                                                            modulesToChildOpsState
                                                                .modules[index]
                                                                .id,
                                                      );
                                                    }
                                                    return BlocBuilder<
                                                        ModulesCompletionOpsCubit,
                                                        ModulesCompletionOpsState>(
                                                      builder:
                                                          (_, modulesCompletionOpsState) =>
                                                              Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: utils.padding +
                                                              utils
                                                                  .tinyPadding +
                                                              utils.tinyPadding,
                                                        ),
                                                        child: Card(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                              utils.padding,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        modulesToChildOpsState
                                                                            .modules[index]
                                                                            .data()
                                                                            .name,
                                                                        maxLines: utils
                                                                            .veryTinyPadding
                                                                            .toInt(),
                                                                        overflow:
                                                                            TextOverflow.fade,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              utils.padding,
                                                                          color:
                                                                              Theme.of(context).primaryColorLight,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      modulesToChildOpsState.modules[index].data().timestamp !=
                                                                              null
                                                                          ? const SizedBox(
                                                                              height: utils.smallPadding,
                                                                            )
                                                                          : const SizedBox(
                                                                              width: utils.nil,
                                                                              height: utils.nil,
                                                                            ),
                                                                      modulesToChildOpsState.modules[index].data().timestamp !=
                                                                              null
                                                                          ? Text(
                                                                              DateFormat(utils.quizDateFormatText)
                                                                                  .format(
                                                                                    modulesToChildOpsState.modules[index].data().timestamp!.toDate(),
                                                                                  )
                                                                                  .toLowerCase(),
                                                                              maxLines: utils.veryTinyPadding.toInt(),
                                                                              overflow: TextOverflow.fade,
                                                                              style: TextStyle(
                                                                                fontSize: utils.padding - (utils.tinyPadding + utils.veryTinyPadding),
                                                                                color: Theme.of(context).primaryColorLight,
                                                                                fontWeight: FontWeight.w300,
                                                                              ),
                                                                            )
                                                                          : const SizedBox(
                                                                              width: utils.nil,
                                                                              height: utils.nil,
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: (utils.largePadding +
                                                                          utils
                                                                              .padding +
                                                                          utils
                                                                              .smallPadding) -
                                                                      utils
                                                                          .veryTinyPadding,
                                                                  height: (utils
                                                                              .largePadding +
                                                                          utils
                                                                              .padding +
                                                                          utils
                                                                              .smallPadding) -
                                                                      utils
                                                                          .veryTinyPadding,
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      CircularProgressIndicator(
                                                                        value: modulesCompletionOpsState
                                                                                is GotModulesCompletionState
                                                                            ? modulesCompletionOpsState.moduleProgress.value
                                                                            : utils.nil,
                                                                        backgroundColor: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                          utils
                                                                              .nilDotTwoOne,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        modulesCompletionOpsState
                                                                                is GotModulesCompletionState
                                                                            ? modulesCompletionOpsState.moduleProgress.number.toString() +
                                                                                utils.percentText
                                                                            : utils.percentText,
                                                                        maxLines: utils
                                                                            .veryTinyPadding
                                                                            .toInt(),
                                                                        overflow:
                                                                            TextOverflow.fade,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              utils.padding - (utils.tinyPadding + utils.veryTinyPadding),
                                                                          color:
                                                                              Theme.of(context).primaryColorLight,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: utils
                                                                      .padding,
                                                                ),
                                                                ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all<
                                                                            Color>(
                                                                      Theme.of(
                                                                              context)
                                                                          .floatingActionButtonTheme
                                                                          .backgroundColor!,
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushNamed(
                                                                      utils
                                                                          .quizzesToQuestionsTransitionScreenRoute,
                                                                      arguments: modulesToChildOpsState
                                                                          .modules[
                                                                              index]
                                                                          .id,
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    utils
                                                                        .startText,
                                                                    maxLines: utils
                                                                        .veryTinyPadding
                                                                        .toInt(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: utils
                                                                              .padding -
                                                                          utils
                                                                              .veryTinyPadding,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
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
                                                                utils
                                                                    .smallPadding) -
                                                            utils.tinyPadding,
                                                        color: Theme.of(context)
                                                            .primaryColorLight
                                                            .withOpacity(
                                                              utils
                                                                  .nilDotFiveFive,
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: utils
                                                                .tinyPadding +
                                                            utils.tinyPadding,
                                                      ),
                                                      BlocBuilder<
                                                          ChildDetailsOpsCubit,
                                                          ChildDetailsOpsState>(
                                                        builder:
                                                            (_, childDetailsOpsState) =>
                                                                RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              fontSize: utils
                                                                      .padding +
                                                                  utils
                                                                      .veryTinyPadding,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight
                                                                  .withOpacity(
                                                                    utils
                                                                        .nilDotFiveFive,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            children: [
                                                              const TextSpan(
                                                                text: utils
                                                                    .noAvailableQuizzesForText,
                                                              ),
                                                              const TextSpan(
                                                                text: utils
                                                                    .whiteSpaceText,
                                                              ),
                                                              TextSpan(
                                                                text: childDetailsOpsState
                                                                        is GotChildDetailsState
                                                                    ? childDetailsOpsState
                                                                        .child
                                                                        .data()!
                                                                        .name
                                                                    : utils
                                                                        .emptyStringText,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                    ),
                                  ],
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
                                backgroundColor:
                                    Theme.of(context).primaryColorLight,
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
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      );
}
