import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase/bloc_observer.dart';
import 'package:flutter_bloc_firebase/profile/dashboard/dashboard_page.dart';
import 'package:flutter_bloc_firebase/profile/sign_up/view/sign_up_page.dart';
import 'package:profile_repository/profile_repository.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(),
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
        ),
      ],
      // child: BlocProvider(
      //     create: (BuildContext context) =>
      //         AuthenticationBloc(RepositoryProvider.of<AuthenticationRepository>(context)),
      //     child: MyApp()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final home = MaterialApp(
    debugShowCheckedModeBanner:false,
    title: 'Flutter BLoC Firebase',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    routes: <String, WidgetBuilder>{
      '/dashboard': (BuildContext context) => DashboardPage()
    },
    home: SignUpPage(),
  );

  final error = MaterialApp(
    title: 'Error',
    theme: ThemeData(
      primarySwatch: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: ErrorPage(),
  );

  final splash = MaterialApp(
    title: 'Flutter BLoC Firebase',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Splash(),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,

      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return error;
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return home;
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return splash;
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Oops!')),
    );
  }
}
