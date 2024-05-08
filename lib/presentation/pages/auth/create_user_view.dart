import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateUserView extends HookConsumerWidget {
  const CreateUserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: Center(
        child: const Text('ユーザ情報登録画面'),
      ),
    );
  }
}
