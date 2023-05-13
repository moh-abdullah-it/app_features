import 'package:flutter/material.dart';

class TestBottomSheetPage extends StatelessWidget {
  const TestBottomSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Text('Test Text Title'),
    );
  }
}
