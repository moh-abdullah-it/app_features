import 'package:app_features/app_features.dart';
import 'package:app_features/src/widgets/LoadingWidget.dart';
import 'package:flutter/material.dart';
const loadingPath = '/base/loading';
GoRoute loadingRoute ({Widget? loadingWidget}) => GoRoute(
    path: loadingPath,
    name: loadingPath,
    pageBuilder: (context, state) => DialogPage(
        dismissible: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        page: loadingWidget ?? LoadingWidget(key: state.pageKey)
    )
);