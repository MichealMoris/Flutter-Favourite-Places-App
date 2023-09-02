import 'package:flutter/material.dart';

dynamic defaultNavigate(BuildContext context, Widget to) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return to;
      },
    ),
  );
}

void defaultPop(BuildContext context, {result}) {
  Navigator.of(context).pop(result);
}
