import 'package:flutter/material.dart';

ScaffoldFeatureController buildSnackBarWithAction(
    BuildContext context, String label, String actionLabel,
    {required Function() onActionClicked}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 6),
      content: Text(label),
      action: SnackBarAction(
        label: actionLabel,
        onPressed: () {
          onActionClicked();
        },
      ),
    ),
  );
}

ScaffoldFeatureController buildSnackBar(BuildContext context, String label) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(label)),
  );
}
