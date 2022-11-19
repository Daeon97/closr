import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen>
    with SingleTickerProviderStateMixin {
  late StateMachineController _stateMachineController;
  late SMIInput<double> _levelSMIInput;

  utils.Category? initialCategory;

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
    )!;

    if (initialCategory != null) {
      switch (initialCategory!) {
        case utils.Category.child:
          _levelSMIInput.value = utils.nil;
          break;
        case utils.Category.parent:
          _levelSMIInput.value = utils.tinyPadding;
          break;
      }
    }

    _stateMachineController = stateMachineController;
  }

  @override
  void initState() {
    final categoryState = BlocProvider.of<CategoryCubit>(context).state;
    initialCategory = categoryState.category;

    super.initState();
  }

  @override
  void dispose() {
    _stateMachineController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<CategoryCubit, CategoryState>(
        listener: (_, categoryState) {
          switch (categoryState.category) {
            case utils.Category.child:
              _levelSMIInput.value = utils.nil;
              break;
            case utils.Category.parent:
              _levelSMIInput.value = utils.tinyPadding;
              break;
          }
        },
        child: Scaffold(
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
                    height: utils.fourHundredDotNil,
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
                    child: BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (categoryCtx, categoryState) => Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                categoryCtx.read<CategoryCubit>().setCategory(
                                      utils.Category.child,
                                    );
                              },
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
                                  color: categoryState.category ==
                                          utils.Category.child
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    utils.childText,
                                    style: TextStyle(
                                      color: categoryState.category ==
                                              utils.Category.child
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
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
                              onTap: () {
                                categoryCtx.read<CategoryCubit>().setCategory(
                                      utils.Category.parent,
                                    );
                              },
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
                                  color: categoryState.category ==
                                          utils.Category.parent
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    utils.parentText,
                                    style: TextStyle(
                                      color: categoryState.category ==
                                              utils.Category.parent
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
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
                  ),
                  const SizedBox(
                    height: utils.largePadding,
                  ),
                  BlocBuilder<ScreenToShowCubit, ScreenToShowState>(
                    builder: (screenToShowCtx, screenToShowState) =>
                        BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (categoryCtx, categoryState) => ElevatedButton(
                        onPressed: () {
                          screenToShowCtx
                              .read<ScreenToShowCubit>()
                              .setScreenToShow(
                                categoryState.category == utils.Category.child
                                    ? utils.ScreenToShow.signIn
                                    : utils.ScreenToShow.signUp,
                              );
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(
                              utils.padding,
                            ),
                            child: Text(
                              utils.proceedText,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
