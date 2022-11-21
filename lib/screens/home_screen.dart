import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StateMachineController _stateMachineController;
  late SMIInput<double> _bodiesSMIInput;
  late SMIInput<double> _eyesSMIInput;
  late SMIInput<double> _mouthSMIInput;

  void _onInit(
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

    _mouthSMIInput = stateMachineController.findInput(
      utils.avatarPrototypeCharacterMouthSMIInput,
    )!;

    _stateMachineController = stateMachineController;
  }

  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).listenUserChanges();
    BlocProvider.of<ChildOpsCubit>(context).listenChildrenChanges();

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
    _stateMachineController.dispose();

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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: utils.padding,
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
                              onInit: _onInit,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                utils.padding,
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
                            BlocBuilder<ChildOpsCubit, ChildOpsState>(
                              builder: (_, childOpsState) => SizedBox(
                                height: utils.childrenCardHeight,
                                width: childOpsState is ChildOpsInitialState
                                    ? MediaQuery.of(context).size.width
                                    : null,
                                child: childOpsState is GotChildrenState
                                    ? childOpsState.children.isNotEmpty ?
                                ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (_, index) => Card(
                                            // color: ,
                                            ),
                                      )
                                : Center()
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: utils.nil,
                        bottom: utils.largePadding,
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
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            utils.padding,
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
                          height: utils.questionModulesHeight,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (_, index) => Card(),
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
