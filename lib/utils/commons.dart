import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubits/cubits.dart';
import 'constants.dart' as constants;

void showError(
  BuildContext context, {
  required String message,
}) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).errorColor,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(
          constants.padding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Theme.of(context).primaryColorLight,
            ),
            const SizedBox(
              height: constants.padding,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ],
        ),
      ),
    );

void showInfo(
  BuildContext context, {
  required String message,
}) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).primaryColorLight,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(
          constants.padding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.circleInfo,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              height: constants.padding,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );

void addChild(
  BuildContext context,
) {
  final formKey = GlobalKey<FormState>();

  String name = constants.emptyStringText;
  String age = constants.emptyStringText;
  String gender = constants.emptyStringText;
  String mClass = constants.emptyStringText;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              constants.padding + constants.tinyPadding + constants.tinyPadding,
            ),
          ),
        ),
        margin: const EdgeInsets.all(
          constants.padding,
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            constants.padding,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      constants.fillInChildsDetailsText,
                      style: TextStyle(
                        fontSize: (constants.smallPadding +
                                constants.smallPadding) -
                            (constants.tinyPadding + constants.veryTinyPadding),
                        color: Theme.of(context)
                            .floatingActionButtonTheme
                            .backgroundColor,
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: constants.nameText,
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) => value == null || value.isEmpty
                        ? constants.emptyNameFieldText
                        : null,
                  ),
                  const SizedBox(
                    height: constants.padding,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: constants.ageText,
                    ),
                    onChanged: (value) {
                      age = value;
                    },
                    validator: (value) => value == null || value.isEmpty
                        ? constants.emptyAgeFieldText
                        : null,
                  ),
                  const SizedBox(
                    height: constants.padding,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              constants.genderText,
                            ),
                            DropdownButtonFormField<String>(
                              items: List<DropdownMenuItem<String>>.generate(
                                constants.tinyPadding.toInt(),
                                (index) => DropdownMenuItem<String>(
                                  value: index == constants.nil.toInt()
                                      ? constants.maleText
                                      : constants.femaleText,
                                  child: Text(
                                    index == constants.nil.toInt()
                                        ? constants.maleText
                                        : constants.femaleText,
                                  ),
                                ),
                                growable: false,
                              ),
                              onChanged: (value) {
                                gender = value ?? constants.emptyStringText;
                              },
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? constants.emptyGenderFieldText
                                      : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: constants.padding,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              constants.classText,
                            ),
                            DropdownButtonFormField<String>(
                              items: List<DropdownMenuItem<String>>.generate(
                                constants.smallPadding.toInt() -
                                    constants.tinyPadding.toInt(),
                                (index) => DropdownMenuItem<String>(
                                  value: index == constants.nil.toInt()
                                      ? constants.jss1Text
                                      : index ==
                                              constants.veryTinyPadding.toInt()
                                          ? constants.jss2Text
                                          : index ==
                                                  constants.tinyPadding.toInt()
                                              ? constants.jss3Text
                                              : index ==
                                                      constants.tinyPadding
                                                              .toInt() +
                                                          constants
                                                              .veryTinyPadding
                                                              .toInt()
                                                  ? constants.sss1Text
                                                  : index ==
                                                          constants.tinyPadding
                                                                  .toInt() +
                                                              constants
                                                                  .tinyPadding
                                                                  .toInt()
                                                      ? constants.sss2Text
                                                      : constants.sss3Text,
                                  child: Text(
                                    index == constants.nil.toInt()
                                        ? constants.jss1Text
                                        : index ==
                                                constants.veryTinyPadding
                                                    .toInt()
                                            ? constants.jss2Text
                                            : index ==
                                                    constants.tinyPadding
                                                        .toInt()
                                                ? constants.jss3Text
                                                : index ==
                                                        constants.tinyPadding
                                                                .toInt() +
                                                            constants
                                                                .veryTinyPadding
                                                                .toInt()
                                                    ? constants.sss1Text
                                                    : index ==
                                                            constants
                                                                    .tinyPadding
                                                                    .toInt() +
                                                                constants
                                                                    .tinyPadding
                                                                    .toInt()
                                                        ? constants.sss2Text
                                                        : constants.sss3Text,
                                  ),
                                ),
                                growable: false,
                              ),
                              onChanged: (value) {
                                mClass = value ?? constants.emptyStringText;
                              },
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? constants.emptyClassFieldText
                                      : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: constants.largePadding,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context)
                            .floatingActionButtonTheme
                            .backgroundColor!,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<ChildOpsCubit>(context).addChild(
                          name: name,
                          age: int.parse(age),
                          gender: gender,
                          mClass: mClass,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Center(
                      child: Text(
                        constants.addChildText,
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
  );
}
