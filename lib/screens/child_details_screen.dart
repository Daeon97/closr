import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import '../cubits/cubits.dart';
import '../models/models.dart' as models;
import '../utils/utils.dart' as utils;

class ChildDetailsScreen extends StatefulWidget {
  const ChildDetailsScreen(this._id, {Key? key}) : super(key: key);

  final String _id;

  @override
  State<ChildDetailsScreen> createState() => _ChildDetailsScreenState();
}

class _ChildDetailsScreenState extends State<ChildDetailsScreen> {
  void _onChildAvatarInit(
    Artboard artboard,
    models.Child child,
  ) {
    final stateMachineController = StateMachineController.fromArtboard(
      artboard,
      utils.avatarPrototypeCharacterStateMachineName,
    )!;

    artboard.addController(
      stateMachineController,
    );

    stateMachineController
            .findInput<double>(
              utils.avatarPrototypeCharacterBodiesSMIInput,
            )!
            .value =
        child.gender == utils.maleText
            ? utils.veryTinyPadding
            : (utils.tinyPadding + utils.tinyPadding);

    stateMachineController
            .findInput<double>(
              utils.avatarPrototypeCharacterEyesSMIInput,
            )!
            .value =
        child.gender == utils.maleText
            ? utils.tinyPadding
            : utils.veryTinyPadding;

    stateMachineController
        .findInput<double>(
          utils.avatarPrototypeCharacterMouthSMIInput,
        )!
        .value = child.gender == utils.maleText ? utils.nil : utils.tinyPadding;
  }

  @override
  void initState() {
    BlocProvider.of<ChildDetailsOpsCubit>(context)
        .listenChildDetailsChanges(widget._id);

    super.initState();
  }

  @override
  void deactivate() {
    BlocProvider.of<ChildDetailsOpsCubit>(context)
        .stopListeningChildDetailsChanges();

    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<ChildDetailsOpsCubit, ChildDetailsOpsState>(
          builder: (_, childDetailsOpsState) => childDetailsOpsState
                  is GotChildDetailsState
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: utils.largePadding,
                      horizontal: utils.padding,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: utils.padding,
                                  right: utils.padding,
                                  bottom: utils.padding,
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: utils.childDetailsFirstCardHeight -
                                      utils.largePadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              childDetailsOpsState.child
                                                  .data()!
                                                  .name,
                                              maxLines:
                                                  utils.veryTinyPadding.toInt(),
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontSize: utils.largePadding +
                                                    utils.tinyPadding,
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: utils.largePadding +
                                                utils.padding +
                                                utils.smallPadding -
                                                (utils.tinyPadding +
                                                    utils.veryTinyPadding),
                                            width: utils.veryLargePadding +
                                                utils.padding,
                                            child: RiveAnimation.asset(
                                              utils
                                                  .avatarPrototypeCharacterRiveAsset,
                                              onInit: (artboard) =>
                                                  _onChildAvatarInit(
                                                      artboard,
                                                      childDetailsOpsState.child
                                                          .data()!),
                                            ),
                                          ),
                                        ],
                                      ),
                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    utils.ageText.toLowerCase(),
                                                    style: TextStyle(
                                                      fontSize: utils.padding +
                                                          utils.tinyPadding +
                                                          utils.tinyPadding,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  Text(
                                                    childDetailsOpsState.child
                                                        .data()!
                                                        .age
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          utils.largePadding +
                                                              utils.tinyPadding,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: utils.padding,
                                                  ),
                                                  Text(
                                                    utils.genderText
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                      fontSize: utils.padding +
                                                          utils.tinyPadding +
                                                          utils.tinyPadding,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  Text(
                                                    childDetailsOpsState.child
                                                        .data()!
                                                        .gender,
                                                    style: TextStyle(
                                                      fontSize:
                                                          utils.largePadding +
                                                              utils.tinyPadding,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: Theme.of(context)
                                                  .primaryColorLight
                                                  .withOpacity(
                                                    utils.nilDotThreeEight,
                                                  ),
                                              width: utils.tinyPadding,
                                              thickness: utils.tinyPadding,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    utils.classText
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                      fontSize: utils.padding +
                                                          utils.tinyPadding +
                                                          utils.tinyPadding,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  Text(
                                                    childDetailsOpsState.child
                                                        .data()!
                                                        .mClass,
                                                    style: TextStyle(
                                                      fontSize:
                                                          utils.largePadding +
                                                              utils.tinyPadding,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                  heroTag: utils.differentHeroTagText,
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
                        const SizedBox(
                          height: utils.smallPadding + utils.tinyPadding,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(
                              utils.padding,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      utils.addModuleText,
                                      style: TextStyle(
                                        fontSize:
                                            utils.padding + utils.smallPadding,
                                        color: Theme.of(context)
                                            .primaryColorLight
                                            .withOpacity(
                                              utils.nilDotFiveFive,
                                            ),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: utils.largePadding +
                                        utils.tinyPadding +
                                        utils.tinyPadding,
                                    height: utils.largePadding +
                                        utils.tinyPadding +
                                        utils.tinyPadding,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          utils.addModulesToChildScreenRoute,
                                          arguments: widget._id,
                                        );
                                      },
                                      child: const Icon(
                                        FontAwesomeIcons.plus,
                                        size: utils.largePadding,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: utils.smallPadding + utils.tinyPadding,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(
                              utils.padding,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  utils.moduleProgressText,
                                  style: TextStyle(
                                    fontSize:
                                        utils.padding + utils.smallPadding,
                                    color: Theme.of(context)
                                        .primaryColorLight
                                        .withOpacity(
                                          utils.nilDotFiveFive,
                                        ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: utils.childDetailsThirdCardHeight -
                                      (utils.padding + utils.smallPadding),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        utils.clickTheText,
                                        style: TextStyle(
                                          fontSize: utils.padding +
                                              utils.veryTinyPadding,
                                          color: Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(
                                                utils.nilDotFiveFive,
                                              ),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: utils.tinyPadding +
                                            utils.tinyPadding,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.circlePlus,
                                        size: (utils.largePadding +
                                                utils.smallPadding) -
                                            utils.tinyPadding,
                                        color: Theme.of(context)
                                            .primaryColorLight
                                            .withOpacity(
                                              utils.nilDotFiveFive,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: utils.tinyPadding +
                                            utils.tinyPadding,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: utils
                                                  .toAssignQuestionModulesToText,
                                            ),
                                            const TextSpan(
                                              text: utils.whiteSpaceText,
                                            ),
                                            TextSpan(
                                              text: childDetailsOpsState.child
                                                  .data()!
                                                  .name,
                                            ),
                                          ],
                                          style: TextStyle(
                                            fontSize: utils.padding +
                                                utils.veryTinyPadding,
                                            color: Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(
                                                  utils.nilDotFiveFive,
                                                ),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: utils.smallPadding + utils.tinyPadding,
                        ),
                        const SizedBox(
                          height: utils.smallPadding + utils.tinyPadding,
                        ),
                        Card(
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                utils.padding,
                              ),
                            ),
                            onTap: () {
                              //.
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(
                                utils.padding,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        utils.historyText,
                                        style: TextStyle(
                                          fontSize: utils.padding +
                                              utils.tinyPadding +
                                              utils.tinyPadding,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.clock,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      size: utils.padding +
                                          utils.tinyPadding +
                                          utils.tinyPadding,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: utils.smallPadding + utils.tinyPadding,
                        ),
                        Card(
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                utils.padding,
                              ),
                            ),
                            onTap: () {
                              //.
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(
                                utils.padding,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        utils.connectWithAProfessionalText,
                                        style: TextStyle(
                                          fontSize: utils.padding +
                                              utils.tinyPadding +
                                              utils.tinyPadding,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.briefcase,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      size: utils.padding +
                                          utils.tinyPadding +
                                          utils.tinyPadding,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      );
}
