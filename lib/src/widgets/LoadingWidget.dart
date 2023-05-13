import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
         Padding(
           padding: EdgeInsets.all(16.0),
           child: CircularProgressIndicator(),
         ),
      ],
    );
  }
}
