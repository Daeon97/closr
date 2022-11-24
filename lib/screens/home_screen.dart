import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import '../cubits/cubits.dart';
import '../models/models.dart' as models;
import '../utils/utils.dart' as utils;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SMIInput<double> _bodiesSMIInput;
  late SMIInput<double> _eyesSMIInput;
  late SMIInput<double> _mouthSMIInput;

  late ScrollController _childrenScrollController;
  late ScrollController _modulesScrollController;

  void _onParentAvatarInit(
    Artboard artboard,
  ) {
    final stateMachineController = StateMachineController.fromArtboard(
      artboard,
      utils.avatarPrototypeCharacterStateMachineName,
    )!;

    artboard.addController(
      stateMachineController,
    );

    _bodiesSMIInput = stateMachineController.findInput<double>(
      utils.avatarPrototypeCharacterBodiesSMIInput,
    )!;

    _eyesSMIInput = stateMachineController.findInput<double>(
      utils.avatarPrototypeCharacterEyesSMIInput,
    )!
      ..value = utils.tinyPadding + utils.tinyPadding;

    _mouthSMIInput = stateMachineController.findInput<double>(
      utils.avatarPrototypeCharacterMouthSMIInput,
    )!;
  }

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
    _childrenScrollController = ScrollController();
    _modulesScrollController = ScrollController();

    BlocProvider.of<AuthCubit>(context).listenUserChanges();
    BlocProvider.of<ChildOpsCubit>(context).listenChildrenChanges();
    BlocProvider.of<ModuleOpsCubit>(context).getModules();

    super.initState();
  }

  @override
  void deactivate() {
    BlocProvider.of<AuthCubit>(context).stopListeningUserChanges();
    BlocProvider.of<ChildOpsCubit>(context).stopListeningChildrenChanges();

    super.deactivate();
  }

  @override
  void dispose() {
    _childrenScrollController.dispose();
    _modulesScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (_, authState) {
          if (authState is UnAuthenticatedState && authState.route != null) {
            Navigator.of(context).pushReplacementNamed(
              authState.route!,
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: utils.padding,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: utils.padding,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                utils.helloText +
                                    utils.whiteSpaceText +
                                    utils.waveHandSignEmoji,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                BlocProvider.of<AuthCubit>(context)
                                        .currentUser
                                        ?.displayName ??
                                    utils.emptyStringText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: utils.oneDotFive,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: utils.veryLargePadding +
                              utils.padding +
                              utils.smallPadding,
                          height: utils.veryLargePadding +
                              utils.padding +
                              utils.smallPadding,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {
                              if ((_bodiesSMIInput.value !=
                                      utils.smallPadding - utils.tinyPadding) &&
                                  (_eyesSMIInput.value != utils.tinyPadding) &&
                                  (_mouthSMIInput.value !=
                                      utils.veryTinyPadding)) {
                                _bodiesSMIInput.value =
                                    utils.smallPadding - utils.tinyPadding;
                                _eyesSMIInput.value = utils.tinyPadding;
                                _mouthSMIInput.value = utils.veryTinyPadding;
                              } else {
                                _bodiesSMIInput.value = utils.nil;
                                _eyesSMIInput.value =
                                    utils.tinyPadding + utils.tinyPadding;
                                _mouthSMIInput.value = utils.nil;
                              }

                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        utils.smallPadding,
                                      ),
                                    ),
                                  ),
                                  margin: const EdgeInsets.all(
                                    utils.padding,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: utils.padding,
                                      vertical: utils.smallPadding,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: utils.padding,
                                            ),
                                            child: Text(
                                              utils.signOutQuestionText,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            utils.signOutText,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.fontSize,
                                              fontWeight: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.fontWeight,
                                            ),
                                          ),
                                          onPressed: () {
                                            BlocProvider.of<AuthCubit>(context)
                                                .signOut();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: RiveAnimation.asset(
                              utils.avatarPrototypeCharacterRiveAsset,
                              onInit: _onParentAvatarInit,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: utils.padding,
                        ),
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: utils.padding,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: utils.padding,
                              ),
                              child: Text(
                                utils.childrenText,
                                style: TextStyle(
                                  fontSize:
                                      utils.padding + utils.veryTinyPadding,
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
                              height:
                                  utils.childrenCardHeight - utils.largePadding,
                              width: MediaQuery.of(context).size.width,
                              child: BlocBuilder<ChildOpsCubit, ChildOpsState>(
                                builder: (_, childOpsState) =>
                                    childOpsState is GotChildrenState
                                        ? childOpsState.children.isNotEmpty
                                            ? Scrollbar(
                                                controller:
                                                    _childrenScrollController,
                                                child: ListView.builder(
                                                  controller:
                                                      _childrenScrollController,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: childOpsState
                                                      .children.length,
                                                  itemBuilder: (_, index) =>
                                                      Card(
                                                    margin: EdgeInsets.only(
                                                      top: utils.padding,
                                                      bottom: utils.padding,
                                                      left: utils.padding,
                                                      right: index ==
                                                              (childOpsState
                                                                      .children
                                                                      .length -
                                                                  utils
                                                                      .veryTinyPadding
                                                                      .toInt())
                                                          ? utils.padding
                                                          : utils.nil,
                                                    ),
                                                    child: InkWell(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(
                                                          utils.padding,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                          utils
                                                              .childDetailsScreenRoute,
                                                          arguments:
                                                              childOpsState
                                                                  .children[
                                                                      index]
                                                                  .id,
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal:
                                                              utils.padding,
                                                        ),
                                                        child: SizedBox(
                                                          width: utils
                                                              .childrenCardWidth,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      childOpsState
                                                                          .children[
                                                                              index]
                                                                          .data()
                                                                          .name,
                                                                      maxLines: utils
                                                                          .veryTinyPadding
                                                                          .toInt(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            utils.largePadding +
                                                                                utils.tinyPadding,
                                                                        color: Theme.of(context)
                                                                            .primaryColorLight,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: utils
                                                                        .veryLargePadding,
                                                                    width: utils
                                                                            .veryLargePadding +
                                                                        utils
                                                                            .padding,
                                                                    child: RiveAnimation
                                                                        .asset(
                                                                      utils
                                                                          .avatarPrototypeCharacterRiveAsset,
                                                                      onInit: (artboard) =>
                                                                          _onChildAvatarInit(
                                                                        artboard,
                                                                        childOpsState
                                                                            .children[index]
                                                                            .data(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              IntrinsicHeight(
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            utils.ageText.toLowerCase(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: utils.padding + utils.tinyPadding + utils.tinyPadding,
                                                                              color: Theme.of(context).primaryColorLight,
                                                                              fontWeight: FontWeight.w300,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            childOpsState.children[index].data().age.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: utils.largePadding + utils.tinyPadding,
                                                                              color: Theme.of(context).primaryColorLight,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: utils
                                                                          .padding,
                                                                    ),
                                                                    VerticalDivider(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight
                                                                          .withOpacity(
                                                                            utils.nilDotThreeEight,
                                                                          ),
                                                                      width: utils
                                                                          .tinyPadding,
                                                                      thickness:
                                                                          utils
                                                                              .tinyPadding,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: utils
                                                                          .padding,
                                                                    ),
                                                                    Expanded(
                                                                      flex: utils
                                                                              .tinyPadding
                                                                              .toInt() +
                                                                          utils
                                                                              .veryTinyPadding
                                                                              .toInt(),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            utils.classText.toLowerCase(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: utils.padding + utils.tinyPadding + utils.tinyPadding,
                                                                              color: Theme.of(context).primaryColorLight,
                                                                              fontWeight: FontWeight.w300,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            childOpsState.children[index].data().mClass,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: utils.largePadding + utils.tinyPadding,
                                                                              color: Theme.of(context).primaryColorLight,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: utils
                                                                        .padding +
                                                                    utils
                                                                        .tinyPadding,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              utils.veryLargePadding,
                                                                          height:
                                                                              utils.veryLargePadding,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            value:
                                                                                utils.nil,
                                                                            backgroundColor:
                                                                                Colors.black.withOpacity(
                                                                              utils.nilDotTwoOne,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(
                                                                            utils.padding,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            utils.temperText,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: utils.smallPadding + utils.tinyPadding + utils.tinyPadding,
                                                                              color: Theme.of(context).primaryColorLight,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: utils
                                                                        .padding,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              utils.veryLargePadding,
                                                                          height:
                                                                              utils.veryLargePadding,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            value:
                                                                                utils.nil,
                                                                            backgroundColor:
                                                                                Colors.black.withOpacity(
                                                                              utils.nilDotTwoOne,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(
                                                                            utils.padding,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            utils.depressionText,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: utils.smallPadding + utils.tinyPadding + utils.tinyPadding,
                                                                              color: Theme.of(context).primaryColorLight,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: utils
                                                                        .padding,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              utils.veryLargePadding,
                                                                          height:
                                                                              utils.veryLargePadding,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            value:
                                                                                utils.nil,
                                                                            backgroundColor:
                                                                                Colors.black.withOpacity(
                                                                              utils.nilDotTwoOne,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(
                                                                            utils.padding,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            utils.complianceText,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: utils.smallPadding + utils.tinyPadding + utils.tinyPadding,
                                                                              color: Theme.of(context).primaryColorLight,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
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
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: utils.padding,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      utils.clickTheText,
                                                      style: TextStyle(
                                                        fontSize: utils
                                                                .padding +
                                                            utils
                                                                .veryTinyPadding,
                                                        color: Theme.of(context)
                                                            .primaryColorLight
                                                            .withOpacity(
                                                              utils
                                                                  .nilDotFiveFive,
                                                            ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height:
                                                          utils.tinyPadding +
                                                              utils.tinyPadding,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .circlePlus,
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
                                                      height:
                                                          utils.tinyPadding +
                                                              utils.tinyPadding,
                                                    ),
                                                    Text(
                                                      utils
                                                          .toAddKidsToYourProfileText,
                                                      style: TextStyle(
                                                        fontSize: utils
                                                                .padding +
                                                            utils
                                                                .veryTinyPadding,
                                                        color: Theme.of(context)
                                                            .primaryColorLight
                                                            .withOpacity(
                                                              utils
                                                                  .nilDotFiveFive,
                                                            ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: utils.padding,
                        bottom: -(utils.padding +
                            utils.smallPadding +
                            utils.tinyPadding +
                            utils.veryTinyPadding),
                        child: FloatingActionButton(
                          onPressed: () {
                            utils.addChild(
                              context,
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
                  const SizedBox(
                    height: utils.veryLargePadding + utils.padding,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: utils.padding,
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: utils.padding,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: utils.padding,
                          ),
                          child: Text(
                            utils.questionModulesText,
                            style: TextStyle(
                              fontSize: utils.padding + utils.veryTinyPadding,
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
                          height:
                              utils.questionModulesHeight - utils.largePadding,
                          width: MediaQuery.of(context).size.width,
                          child: BlocBuilder<ModuleOpsCubit, ModuleOpsState>(
                            builder: (_, moduleOpsState) => moduleOpsState
                                    is GotModulesState
                                ? moduleOpsState.modules.isNotEmpty
                                    ? Scrollbar(
                                        controller: _modulesScrollController,
                                        child: ListView.builder(
                                          controller: _modulesScrollController,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              moduleOpsState.modules.length,
                                          itemBuilder: (_, index) => Card(
                                            margin: EdgeInsets.only(
                                              top: utils.padding,
                                              bottom: utils.padding,
                                              left: utils.padding,
                                              right: index ==
                                                      (moduleOpsState
                                                              .modules.length -
                                                          utils.veryTinyPadding
                                                              .toInt())
                                                  ? utils.padding
                                                  : utils.nil,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: utils.padding,
                                              ),
                                              child: SizedBox(
                                                width:
                                                    utils.questionModulesWidth,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            moduleOpsState
                                                                .modules[index]
                                                                .data()
                                                                .name,
                                                            maxLines: utils
                                                                .veryTinyPadding
                                                                .toInt(),
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                              fontSize: utils
                                                                      .padding +
                                                                  utils
                                                                      .smallPadding,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: utils
                                                              .veryLargePadding,
                                                          width: utils
                                                                  .veryLargePadding +
                                                              utils.padding,
                                                          child: RiveAnimation
                                                              .asset(
                                                            utils
                                                                .breathingBookCharacterRiveAsset,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      moduleOpsState
                                                          .modules[index]
                                                          .data()
                                                          .description,
                                                      maxLines: utils
                                                          .smallPadding
                                                          .toInt(),
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: TextStyle(
                                                        fontSize: utils
                                                                .padding +
                                                            utils.tinyPadding +
                                                            utils.tinyPadding +
                                                            utils.tinyPadding,
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: utils.padding,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.commentSlash,
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
                                            Text(
                                              utils.noModulesText,
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
                                          ],
                                        ),
                                      )
                                : const Center(
                                    child: CircularProgressIndicator(),
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
        ),
      );
}
