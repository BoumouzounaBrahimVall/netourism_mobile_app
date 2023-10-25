import 'package:flutter/material.dart';

/* EXAMPLE  OF USE
  Navigator.of(context).push(
    SlideLeftRouteWidget(const PushedScreen(),),
  );
 */

// How to use it EnterExitRouteWidget: Navigator.push(context, EnterExitRouteWidget(exitPage: this, enterPage: Screen2()))
class EnterExitRouteWidget extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  EnterExitRouteWidget(this.enterPage, this.exitPage)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}

// How to use it FadeRouteWidget: Navigator.push(context, FadeRouteWidget(const screen()));
class FadeRouteWidget extends PageRouteBuilder {
  final Widget page;
  FadeRouteWidget(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

// How to use it ScaleRouteWidget: Navigator.push(context, ScaleRouteWidget(const screen()));
class ScaleRouteWidget extends PageRouteBuilder {
  final Widget page;
  ScaleRouteWidget(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}

// How to use it SlideRightRouteWidget: Navigator.push(context, SlideRightRouteWidget(const screen()));
class SlideRightRouteWidget extends PageRouteBuilder {
  final Widget page;
  SlideRightRouteWidget(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

// How to use it SlideLeftRouteWidget: Navigator.push(context, SlideLeftRouteWidget(const screen()));
class SlideLeftRouteWidget extends PageRouteBuilder {
  final Widget page;
  SlideLeftRouteWidget(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

// How to use it SlideTopRouteWidget: Navigator.push(context, SlideTopRouteWidget(const screen()));
class SlideTopRouteWidget extends PageRouteBuilder {
  final Widget page;
  SlideTopRouteWidget(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

// How to use it SlideBottomRouteWidget: Navigator.push(context, SlideBottomRouteWidget(const screen()));
class SlideBottomRouteWidget extends PageRouteBuilder {
  final Widget page;
  SlideBottomRouteWidget(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
