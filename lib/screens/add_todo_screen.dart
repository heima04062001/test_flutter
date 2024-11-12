import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import '../models/todo_item.dart';

class AddToDoScreen extends ConsumerWidget {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('タスク管理アプリ / 追加')),
      body: Column(
        children: [
          TextField(
            controller: taskNameController,
            decoration: InputDecoration(hintText: 'タスク名'),
          ),
          TextField(
            controller: detailsController,
            decoration: InputDecoration(hintText: '詳細'),
          ),
          TextField(
            controller: statusController,
            decoration: InputDecoration(hintText: 'ステータス'),
          ),
          ElevatedButton(
            onPressed: () {
              final provider = ref.read(listProvider.notifier);
              final newItem = ToDoItem(
                id: DateTime.now().toString(),
                taskName: taskNameController.text,
                details: detailsController.text,
                status: statusController.text,
              );
              provider.addItem(newItem);
              context.go('/');
            },
            child: Text('登録'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
        ],
        currentIndex: 1, // ToDo作成画面なので1に設定
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/'); // ホームに遷移
              break;
            case 1:
              // 現在の画面なので何もしない
              break;
          }
        },
      ),
    );
  }
}

