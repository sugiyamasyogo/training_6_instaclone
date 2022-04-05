import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required ValueChanged onConfirmed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => ConfirmDialog(
      title: title,
      content: content,
      onConfirmed: onConfirmed,
    ),
  );
}

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final ValueChanged<bool> onConfirmed;

  const ConfirmDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.onConfirmed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(S.of(context).yes),
          onPressed: () {
            Navigator.pop(context);
            onConfirmed(true);
          },
        ),
        TextButton(
          child: Text(S.of(context).no),
          onPressed: () {
            Navigator.pop(context);
            onConfirmed(false);
          },
        ),
      ],
    );
  }
}
