import 'package:child_museum/common/provider/current_user_provider.dart';
import 'package:child_museum/common/router/router_path.dart';
import 'package:child_museum/presentation/pages/account/account_view.dart';
import 'package:child_museum/presentation/pages/account/enum/screen_type.dart';
import 'package:child_museum/presentation/pages/account/follow/follow_list_view.dart';
import 'package:child_museum/presentation/pages/account/search/search_view.dart';
import 'package:child_museum/presentation/pages/auth/create_user_view.dart';
import 'package:child_museum/presentation/pages/auth/email_verify_view.dart';
import 'package:child_museum/presentation/pages/auth/sign_in_view.dart';
import 'package:child_museum/presentation/pages/auth/sign_up_view.dart';
import 'package:child_museum/presentation/pages/museum/museum_list_view.dart';
import 'package:child_museum/presentation/pages/museum/register/museum_article_view.dart';
import 'package:child_museum/presentation/pages/museum/register/museum_image_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(currentUserProvider);
    return GoRouter(
      initialLocation: RouterPath.museumList,
      routes: [
        GoRoute(
          path: RouterPath.signIn,
          builder: (context, state) {
            return const SignInView();
          },
        ),
        GoRoute(
          path: RouterPath.signUp,
          builder: (context, state) {
            return const SignUpView();
          },
        ),
        GoRoute(
          path: RouterPath.emailVerify,
          builder: (context, state) {
            return const EmailVerifyView();
          },
        ),
        GoRoute(
          path: RouterPath.createUser,
          builder: (context, state) {
            return const CreateUserView();
          },
        ),
        GoRoute(
          path: RouterPath.museumList,
          builder: (context, state) {
            return const MuseumListView();
          },
          routes: [
            GoRoute(
              path: RouterPath.museumRegImage,
              builder: (context, state) {
                return const MuseumImageView();
              },
              routes: [
                GoRoute(
                  path: RouterPath.museumRegArticle,
                  builder: (context, state) {
                    return MuseumArticleView(
                      imageFiles: state.extra as List<XFile>?,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: RouterPath.account,
              builder: (context, state) {
                return const AccountView();
              },
              routes: [
                GoRoute(
                  path: RouterPath.followList,
                  builder: (context, state) {
                    return FollowListView(
                      screenType: state.extra as ScreenType,
                    );
                  },
                ),
                GoRoute(
                  path: RouterPath.search,
                  builder: (context, state) {
                    return const SearchView();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) async {
        await authState.value?.reload();
        // ログイン状態を取得（nullじゃない場合はログイン済み）
        final isAuth = authState.value != null;

        // ログイン状態を取得
        if (!isAuth && state.fullPath != RouterPath.signIn) {
          return RouterPath.signUp;
        } else if (!isAuth && state.fullPath != RouterPath.signUp) {
          return RouterPath.signIn;
        } else if (isAuth && !authState.value!.emailVerified) {
          // ログイン済みかつメールアドレスが確認されていない場合は、メールアドレス確認画面に遷移
          return RouterPath.emailVerify;
        }

        final isState = state.fullPath == RouterPath.signIn ||
            state.fullPath == RouterPath.signUp ||
            state.fullPath == RouterPath.emailVerify;

        if (!isState) {
          return null;
        }
      },
    );
  },
);
