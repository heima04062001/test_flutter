import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo_item.dart';

class ListProvider extends StateNotifier<List<ToDoItem>> {
  // 初期状態は空のリスト
  ListProvider() : super([]);

  // アイテムを追加する
  void addItem(ToDoItem item) {
    state = [...state, item]; // 新しい状態を作成して変更
  }

  // アイテムを変更する
  void modifyItem(String id, ToDoItem updatedItem) {
    final index = state.indexWhere((item) => item.id == id);
    if (index != -1) {
      state = [
        for (final item in state)
          if (item.id == id) updatedItem else item
      ];
    }
  }

  // アイテムを削除する
  void deleteItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  // アイテム一覧を取得する
  List<ToDoItem> getItems() {
    return state;
  }
}

// ListProvider のインスタンスを提供する StateNotifierProvider
final listProvider = StateNotifierProvider<ListProvider, List<ToDoItem>>((ref) {
  return ListProvider();
});