import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/list_provider.dart';
import '../models/todo_item.dart';
import 'home_screen.dart';
import 'edit_todo_screen.dart';
import 'add_todo_screen.dart'; 

class DetailScreen extends ConsumerWidget {
  final String id;

  DetailScreen({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(listProvider.notifier);
    final items = provider.getItems().where((item) => item.id == id).toList();
    final item = items.isNotEmpty ? items.first : null;

    if (item == null) {
      // アイテムが見つからなかった場合
      return Scaffold(
        appBar: AppBar(
          title: Text('タスク管理アプリ / 詳細'),
        ),
        body: Center(
          child: Text('指定されたタスクが見つかりませんでした。'),
        ),
      );
    }

    // アイテムを取得する処理
 

    // item が見つかった場合、TextEditingController を初期化
    final TextEditingController taskNameController = TextEditingController(text: item.taskName);
    final TextEditingController detailsController = TextEditingController(text: item.details);
    final TextEditingController statusController = TextEditingController(text: item.status);

    return Scaffold(
      appBar: AppBar(
        title: Text('タスク管理アプリ / 詳細'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              // 非同期でタスクを削除
               provider.deleteItem(id);
              // 削除後にホーム画面に遷移
              context.go('/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: taskNameController,
            decoration: InputDecoration(hintText: 'タスク名'),
            readOnly: true,
          ),
          TextField(
            controller: detailsController,
            decoration: InputDecoration(hintText: '詳細'),
            readOnly: true,
          ),
          TextField(
            controller: statusController,
            decoration: InputDecoration(hintText: 'ステータス'),
            readOnly: true,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
        ],
        currentIndex: 0, // ホームが選択されている状態
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/'); // ホームに遷移
              break;
            case 1:
              context.go('/add'); // ToDo作成画面に遷移
              break;
            case 2:
              context.go('/profile'); // プロフィール画面に遷移（仮の遷移先）
              break;
          }
        },
      ),
    );
  }
}

