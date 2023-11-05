import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final Function()? floatingAction;
  final EdgeInsetsGeometry? padding;

  const ScreenWrapper({
    super.key,
    required this.title,
    required this.child,
    this.floatingAction,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        // elevation: 0, // to remove shadow
        // centerTitle: true, // to center the title
        title: Text(
          title,
        ),
        // iconTheme: const IconThemeData(
        //   color: Colors.black,
        // ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: padding,
          child: child,
        ),
      ),
      floatingActionButton: floatingAction != null ? FloatingActionButton(
        onPressed: floatingAction,
        child: const Icon(Icons.add),
      ) : null,
      // resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
    );
  }
}
