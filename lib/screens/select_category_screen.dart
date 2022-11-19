import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  late StateMachineController _stateMachineController;
  late SMIInput<double> _levelSMIInput;

  void _onInit(
    Artboard artboard,
  ) {
    final stateMachineController = StateMachineController.fromArtboard(
      artboard,
      utils.mixingAnimationsCharacterStateMachineName,
    )!;

    artboard.addController(
      stateMachineController,
    );

    _levelSMIInput = stateMachineController.findInput<double>(
      utils.mixingAnimationsCharacterlevelSMIInput,
    )!
      ..value = utils.nil;

    _stateMachineController = stateMachineController;
  }

  @override
  void dispose() {
    _stateMachineController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: utils.largePadding,
              horizontal: utils.padding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        utils.largePadding,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  height: utils.fiveHundredDotNil,
                  child: RiveAnimation.asset(
                    utils.mixingAnimationsCharacterRiveAsset,
                    onInit: _onInit,
                  ),
                ),
                const SizedBox(
                  height: utils.largePadding,
                ),
                Text(
                  utils.selectACategoryText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: utils.padding,
                ),
                Text(
                  utils.selectACategorySubText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: utils.largePadding,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        utils.padding,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(
                              utils.padding,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  utils.padding,
                                ),
                              ),
                              color: Theme.of(context).primaryColorLight,
                            ),
                            child: Center(
                              child: Text(
                                utils.childText,
                                style: TextStyle(
                                  color: utils.bodyLargeTextColor,
                                  fontSize: utils.padding,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(
                              utils.padding,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  utils.padding,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                utils.parentText,
                                style: TextStyle(
                                  color: utils.bodyLargeTextColor,
                                  fontSize: utils.padding,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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
      );
}
