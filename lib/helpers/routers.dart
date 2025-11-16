import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uehmobile/widgets/login.dart';
import 'package:uehmobile/widgets/profile.dart';
import 'package:uehmobile/widgets/register.dart';


class UEHRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/profile',
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const LoginPage(title: "Đăng nhập"),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
                    CurveTween(curve: Curves.easeInOut),
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const RegisterPage(title: "Đăng ký"),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
                    CurveTween(curve: Curves.easeInOut),
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const ProfilePage(title: "Thông tin"),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
                    CurveTween(curve: Curves.easeInOut),
                  ),
                ),
                child: child,
              );
            },
          );
        },
      )
    ],
  );
}