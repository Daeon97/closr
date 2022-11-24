import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class AddModulesToChildScreen extends StatefulWidget {
  const AddModulesToChildScreen({Key? key}) : super(key: key);

  @override
  State<AddModulesToChildScreen> createState() =>
      _AddModulesToChildScreenState();
}

class _AddModulesToChildScreenState extends State<AddModulesToChildScreen> {
  late DragSelectGridViewController _dragSelectGridViewController;

  @override
  void initState() {
    _dragSelectGridViewController = DragSelectGridViewController();

    final childDetailsState =
        BlocProvider.of<ChildDetailsOpsCubit>(context).state;
    if (childDetailsState is GotChildDetailsState) {
      BlocProvider.of<UnAssignedModulesOpsCubit>(context).getNotChildModules(
        childDetailsState.child.id,
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    _dragSelectGridViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<ChildDetailsOpsCubit, ChildDetailsOpsState>(
          builder:
              (_, childDetailsOpsState) =>
                  childDetailsOpsState is GotChildDetailsState
                      ? BlocBuilder<UnAssignedModulesOpsCubit,
                          UnAssignedModulesOpsState>(
                          builder:
                              (_, unAssignedModuleOpsState) =>
                                  unAssignedModuleOpsState
                                          is GotNotChildModulesState
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
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          utils.modulesText,
                                                          maxLines: utils
                                                              .veryTinyPadding
                                                              .toInt(),
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: TextStyle(
                                                            fontSize: utils
                                                                    .largePadding +
                                                                utils
                                                                    .tinyPadding,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: unAssignedModuleOpsState
                                                                  .modules
                                                                  .isNotEmpty
                                                              ? DragSelectGridView(
                                                                  gridController:
                                                                      _dragSelectGridViewController,
                                                                  gridDelegate:
                                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount: utils
                                                                        .tinyPadding
                                                                        .toInt(),
                                                                    crossAxisSpacing:
                                                                        utils
                                                                            .padding,
                                                                    mainAxisSpacing:
                                                                        utils
                                                                            .padding,
                                                                  ),
                                                                  triggerSelectionOnTap:
                                                                      true,
                                                                  itemCount:
                                                                      unAssignedModuleOpsState
                                                                          .modules
                                                                          .length,
                                                                  itemBuilder: (_,
                                                                          index,
                                                                          isSelected) =>
                                                                      Stack(
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: [
                                                                      Card(
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(
                                                                            utils.padding,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                unAssignedModuleOpsState.modules[index].data().name,
                                                                                maxLines: utils.veryTinyPadding.toInt(),
                                                                                overflow: TextOverflow.fade,
                                                                                style: TextStyle(
                                                                                  fontSize: utils.smallPadding + utils.tinyPadding + utils.tinyPadding,
                                                                                  color: Theme.of(context).primaryColorLight,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: utils.padding,
                                                                              ),
                                                                              Text(
                                                                                unAssignedModuleOpsState.modules[index].data().description,
                                                                                maxLines: utils.tinyPadding.toInt() + utils.tinyPadding.toInt(),
                                                                                overflow: TextOverflow.fade,
                                                                                style: TextStyle(
                                                                                  fontSize: utils.padding,
                                                                                  color: Theme.of(context).primaryColorLight,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      isSelected
                                                                          ? Positioned(
                                                                              top: -utils.smallPadding,
                                                                              right: utils.nil,
                                                                              child: Container(
                                                                                padding: const EdgeInsets.all(
                                                                                  utils.tinyPadding + utils.tinyPadding,
                                                                                ),
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.green,
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Icon(
                                                                                  FontAwesomeIcons.check,
                                                                                  color: Theme.of(context).primaryColorLight,
                                                                                  size: utils.padding,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : const SizedBox(
                                                                              width: utils.nil,
                                                                              height: utils.nil,
                                                                            ),
                                                                    ],
                                                                  ),
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
                                                                      BlocBuilder<
                                                                          ChildDetailsOpsCubit,
                                                                          ChildDetailsOpsState>(
                                                                        builder:
                                                                            (_, childDetailsOpsState) =>
                                                                                RichText(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          text:
                                                                              TextSpan(
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: utils.padding + utils.veryTinyPadding,
                                                                              color: Theme.of(context).primaryColorLight.withOpacity(
                                                                                    utils.nilDotFiveFive,
                                                                                  ),
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                            children: [
                                                                              const TextSpan(
                                                                                text: utils.allAvailableQuestionsHaveBeenAddedToText,
                                                                              ),
                                                                              const TextSpan(
                                                                                text: utils.whiteSpaceText,
                                                                              ),
                                                                              TextSpan(
                                                                                text: childDetailsOpsState is GotChildDetailsState ? childDetailsOpsState.child.data()!.name : utils.emptyStringText,
                                                                              ),
                                                                              const TextSpan(
                                                                                text: utils.apostropheSText,
                                                                              ),
                                                                              const TextSpan(
                                                                                text: utils.whiteSpaceText,
                                                                              ),
                                                                              const TextSpan(
                                                                                text: utils.profileText,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                        ),
                                                        const SizedBox(
                                                          height: utils.padding,
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              ValueListenableBuilder(
                                                            valueListenable:
                                                                _dragSelectGridViewController,
                                                            builder: (_,
                                                                    dragSelectGridViewControllerValue,
                                                                    __) =>
                                                                ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    dragSelectGridViewControllerValue
                                                                            .isSelecting
                                                                        ? MaterialStateProperty.all<
                                                                            Color>(
                                                                            Colors.green,
                                                                          )
                                                                        : null,
                                                              ),
                                                              onPressed: dragSelectGridViewControllerValue
                                                                      .selectedIndexes
                                                                      .isNotEmpty
                                                                  ? () {
                                                                      BlocProvider.of<ModulesToChildOpsCubit>(
                                                                              context)
                                                                          .addModulesToChild(
                                                                        childId: childDetailsOpsState
                                                                            .child
                                                                            .id,
                                                                        moduleIds: dragSelectGridViewControllerValue
                                                                            .selectedIndexes
                                                                            .map<String>((index) =>
                                                                                unAssignedModuleOpsState.modules[index].id)
                                                                            .toList(),
                                                                      );
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }
                                                                  : null,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal: utils
                                                                      .padding,
                                                                ),
                                                                child: BlocBuilder<
                                                                    ChildDetailsOpsCubit,
                                                                    ChildDetailsOpsState>(
                                                                  builder: (_,
                                                                          childDetailsOpsState) =>
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        color: dragSelectGridViewControllerValue.isSelecting
                                                                            ? Theme.of(context).primaryColorLight
                                                                            : utils.addModulesToChildScreenButtonColor,
                                                                        fontSize: utils.padding +
                                                                            utils.tinyPadding +
                                                                            utils.veryTinyPadding,
                                                                      ),
                                                                      children: [
                                                                        const TextSpan(
                                                                          text:
                                                                              utils.addToText,
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              utils.whiteSpaceText,
                                                                        ),
                                                                        TextSpan(
                                                                          text: childDetailsOpsState is GotChildDetailsState
                                                                              ? childDetailsOpsState.child.data()!.name
                                                                              : utils.emptyStringText,
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              utils.apostropheSText,
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              utils.whiteSpaceText,
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              utils.profileText,
                                                                        ),
                                                                      ],
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
