import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/list_provider.dart';
import '../models/todo_item.dart';
import 'detail_screen.dart';
import 'edit_todo_screen.dart';
import 'add_todo_screen.dart'; 
import 'package:go_router/go_router.dart';


class EdittoDoScreen extends ConsumerWidget {
  final String id;

  EdittoDoScreen({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(listProvider.notifier);
    final item = provider.getItems().firstWhere((item) => item.id == id);
    final TextEditingController taskNameController = TextEditingController(text: item.taskName);
    final TextEditingController detailsController = TextEditingController(text: item.details);
    final TextEditingController statusController = TextEditingController(text: item.status);

    return Scaffold(
      appBar: AppBar(title: Text('タスク管理アプリ / 編集')),
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
              final updatedItem = ToDoItem(
                id: item.id,
                taskName: taskNameController.text,
                details: detailsController.text,
                status: statusController.text,
              );
              provider.modifyItem(item.id, updatedItem);
              context.go('/');
            },
            child: Text('更新'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ToDo作成'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
        ],
        currentIndex:2,
        onTap: (index) {
          switch (index) {
            case 2:
              context.go('/'); // ホームに遷移
              break;
            case 1:
              context.go('/add'); // ToDo作成画面に遷移
              break;
            case 2:
              context.go('/detail/$id'); // 詳細画面に遷移
              break;
          }
        },
      ),
    );
  }
}

