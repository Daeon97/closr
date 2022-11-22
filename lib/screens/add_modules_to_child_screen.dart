import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import '../cubits/cubits.dart';
import '../models/models.dart' as models;
import '../utils/utils.dart' as utils;

class AddModulesToChildScreen extends StatefulWidget {
  const AddModulesToChildScreen(this._id, {Key? key}) : super(key: key);

  final String _id;

  @override
  State<AddModulesToChildScreen> createState() =>
      _AddModulesToChildScreenState();
}

class _AddModulesToChildScreenState extends State<AddModulesToChildScreen> {
  @override
  void initState() {
    BlocProvider.of<ModuleOpsCubit>(context).getModules();
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<ModuleOpsCubit, ModuleOpsState>(
          builder: (_, moduleOpsState) => moduleOpsState is GotModulesState
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
                                  utils.modulesText,
                                  maxLines: utils.veryTinyPadding.toInt(),
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontSize:
                                        utils.largePadding + utils.tinyPadding,
                                    color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: utils.tinyPadding.toInt(),
                                      crossAxisSpacing: utils.padding,
                                      mainAxisSpacing: utils.padding,
                                    ),
                                    itemCount: moduleOpsState.modules.length,
                                    itemBuilder: (_, index) => Card(
                                      color: Theme.of(context).primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          utils.padding,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              moduleOpsState.modules[index]
                                                  .data()
                                                  .name,
                                              maxLines:
                                                  utils.veryTinyPadding.toInt(),
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontSize: utils.smallPadding +
                                                    utils.tinyPadding +
                                                    utils.tinyPadding,
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: utils.padding,
                                            ),
                                            Text(
                                              moduleOpsState.modules[index]
                                                  .data()
                                                  .description,
                                              maxLines:
                                                  utils.tinyPadding.toInt() +
                                                      utils.tinyPadding.toInt(),
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontSize: utils.padding,
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: utils.padding,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // call function here
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: BlocBuilder<ChildDetailsOpsCubit,
                                        ChildDetailsOpsState>(
                                      builder: (_, childDetailsOpsState) =>
                                          RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: utils
                                                .addModulesToChildScreenButtonColor,
                                            fontSize: utils.padding +
                                                utils.tinyPadding +
                                                utils.veryTinyPadding,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text: utils.addToText,
                                            ),
                                            const TextSpan(
                                              text: utils.whiteSpaceText,
                                            ),
                                            TextSpan(
                                              text: childDetailsOpsState
                                                      is GotChildDetailsState
                                                  ? childDetailsOpsState.child
                                                      .data()!
                                                      .name
                                                  : utils.emptyStringText,
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
