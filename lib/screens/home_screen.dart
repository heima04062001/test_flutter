import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import 'package:go_router/go_router.dart';
import 'edit_todo_screen.dart';
import 'detail_screen.dart';
import 'add_todo_screen.dart';


class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(listProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('タスク管理アプリ')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: '検索欄'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.getItems().length,
              itemBuilder: (context, index) {
                final item = provider.getItems()[index];
                return ListTile(
                  title: Text(item.taskName),
                  subtitle: Text('ステータス: ${item.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          context.go('/edit/${item.id}');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          context.go('/detail/${item.id}');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            print('ToDo作成ボタンがタップされました。');
            context.go('/add');
          }
          // 他の画面への遷移も実装可能
        },
      ),
    );
  }
}
              
