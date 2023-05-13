import 'package:flutter/material.dart';

class TestDialogPage extends StatelessWidget {
  const TestDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Text('Test Text Title'),
    );
  }
}
