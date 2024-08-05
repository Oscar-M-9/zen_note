import 'package:flutter/material.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/generated/l10n.dart';

Future<dynamic> showAlertNotNote(BuildContext context) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            const Icon(
              Icons.warning,
              color: ColorsApp.primary,
            ),
            const SizedBox(width: 10),
            Text(S.of(context).noContentAlertTitle),
          ],
        ),
        content: Text(S.of(context).noContentAlertContent),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).acceptButtonText),
          ),
        ],
      );
    },
  );
}
