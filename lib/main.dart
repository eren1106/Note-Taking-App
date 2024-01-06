import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/routes.dart';
import 'package:note_taking_app/constants/strings.dart';
import 'package:note_taking_app/constants/theme.dart';
import 'package:note_taking_app/services/notification_service.dart';
import 'package:note_taking_app/view/screens/home_screen.dart';
import 'package:note_taking_app/view/screens/login_screen.dart';
import 'package:note_taking_app/view/screens/note_collections_screen.dart';
import 'package:note_taking_app/view/screens/note_detail_screen.dart';
import 'package:note_taking_app/view/screens/notes_screen.dart';
import 'package:note_taking_app/view/screens/settings_screen.dart';
import 'package:note_taking_app/view/screens/signup_screen.dart';
import 'package:note_taking_app/view/screens/sticky_notes_screen.dart';
import 'package:note_taking_app/view/widgets/scaffold_with_nested_navigation.dart';
import 'package:note_taking_app/view_model/note_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  runApp(const MyApp());
}

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> getRootNavigatorKey() => _rootNavigatorKey;
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');
// final _authKey = GlobalKey<NavigatorState>(debugLabel: 'auth');

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: '/${ROUTES_NAME.login}',
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) {
    debugPrint("REDIRECT!");
    // TODO: navigate user to home page if authenticated
    // return '/${ROUTES_NAME.login}';
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/${ROUTES_NAME.login}',
      name: ROUTES_NAME.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/${ROUTES_NAME.signup}',
      name: ROUTES_NAME.signup,
      builder: (context, state) => const SignUpScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        // first branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(),
              ),
              // routes: [
              //   // child route
              //   GoRoute(
              //     path: ROUTES_NAME.noteCollections,
              //     builder: (context, state) => const NoteCollectionsScreen(),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/${ROUTES_NAME.noteCollections}',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: NoteCollectionsScreen(),
              ),
              routes: [
                // child route
                GoRoute(
                  path: ROUTES_NAME.notes,
                  name: ROUTES_NAME.notes,
                  builder: (context, state) => const NotesScreen(),
                  routes: [
                    GoRoute(
                      path: '${ROUTES_NAME.noteDetail}/:id',
                      name: '${ROUTES_NAME.noteDetail}/:id',
                      builder: (context, state) {
                        final id = state.pathParameters['id']!;
                        return NoteDetailScreen(
                          id: id,
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/${ROUTES_NAME.stickyNotes}',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: StickyNotesScreen(),
              ),
              // routes: [
              //   // child route
              //   GoRoute(
              //     path: ROUTES_NAME.noteCollections,
              //     builder: (context, state) => const NoteCollectionsScreen(),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/${ROUTES_NAME.settings}',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsScreen(),
              ),
              // routes: [
              //   // child route
              //   GoRoute(
              //     path: ROUTES_NAME.noteCollections,
              //     builder: (context, state) => const NoteCollectionsScreen(),
              //   ),
              // ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // int _selectedIndex = 0;
  // final List<Widget> _screenOptions =
  //     kNavItems.map((navItem) => navItem.screen).toList();

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: NoteViewModel()),
      ],
      child: MaterialApp.router(
        title: kAppName,
        theme: kThemeData,
        routerConfig: _router,
      ),
    );
  }
}
