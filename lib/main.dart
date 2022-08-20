import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketparser/config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorWidget(details.exception);
  };

  final GoRouter router = initRouter();

  runApp(MaterialApp.router(
    routeInformationProvider: router.routeInformationProvider,
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
    title: 'Ticket Parser Demo',
  ));
}
