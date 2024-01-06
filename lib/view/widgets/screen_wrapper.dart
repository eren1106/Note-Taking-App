import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final Function()? floatingAction;
  final EdgeInsetsGeometry? padding;
  final bool allowDeviceBack;
  final Function? backCallback;
  final bool showAppBar;

  const ScreenWrapper({
    super.key,
    this.title = "",
    required this.child,
    this.floatingAction,
    this.padding = const EdgeInsets.all(20),
    this.allowDeviceBack = true,
    this.backCallback,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(
        // backgroundColor: Colors.white,
        // elevation: 0, // to remove shadow
        // centerTitle: true, // to center the title
        title: Text(
          title,
        ),
        // iconTheme: const IconThemeData(
        //   color: Colors.black,
        // ),
      ) : null,
      body: WillPopScope(
        onWillPop: () async {
          backCallback?.call();
          // Return true to allow the back button press
          // Return false to prevent the back button press
          return allowDeviceBack;
        },
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: padding,
            child: child,
          ),
        ),
      ),
      floatingActionButton: floatingAction != null
          ? FloatingActionButton(
              onPressed: floatingAction,
              child: const Icon(Icons.add),
            )
          : null,
      // resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
    );
  }
}
