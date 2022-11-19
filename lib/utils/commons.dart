import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
