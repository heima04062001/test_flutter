import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/list_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_todo_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/edit_todo_screen.dart';

// GoRouter の設定をトップレベルで定義
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();  // const を削除
      },
    ),
    GoRoute(
      path: '/add',
      builder: (BuildContext context, GoRouterState state) {
        return AddToDoScreen();  // const を削除
      },
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (BuildContext context, GoRouterState state) {
        final String id = state.params['id']!;
        return EdittoDoScreen(id: id);  // const を削除
      },
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (BuildContext context, GoRouterState state) {
        final String id = state.params['id']!;
        return DetailScreen(id: id);  // const を削除
      },
    ),
  ],
);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      title: 'タスク管理アプリ',
    );
  }
}



