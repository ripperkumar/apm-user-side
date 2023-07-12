import 'package:flutter/material.dart';
class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 20.0,
      color: Colors.grey,
      thickness: 1.0,
    );
  }
}
