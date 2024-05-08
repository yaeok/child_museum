import 'package:child_museum/common/router/router_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailVerifyView extends StatelessWidget {
  const EmailVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.go(RouterPath.museumList);
            },
            child: const Text('メールアドレスを認証する'),
          ),
        ),
      ),
    );
  }
}
